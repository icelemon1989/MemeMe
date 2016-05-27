//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Yang Ji on 5/19/16.
//  Copyright © 2016 Yang Ji. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var pickedImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topNaviBar: UINavigationBar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var selectedTextField: UITextField!
    var memedImage: UIImage!
    
//MARK: Text Field Attributes
    let memeTextFieldAttributes: [String: AnyObject] = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: CGFloat(-4.0)
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configure Text Field
        configureTextField(topTextField)
        configureTextField(bottomTextField)
        
        //disable share button before complete image
        shareButton.enabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        //check if camera device availabe
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        
        //sign up to be notified when keyboard appears
        subscribeToKeyboardShowNotification()
        //sign up to be notified when keyboard hide
        subscribToKeyboardHideNotification()
    }
    
    override func viewWillDisappear(animated: Bool) {
        //unsign to be notified when keyboard dismiss
        unsubscribeToKeyboardShowNotification()
    }
    
//MARK: Text Field configure
    func configureTextField(textField: UITextField) {
        textField.delegate = self
        textField.defaultTextAttributes = memeTextFieldAttributes
        textField.textAlignment = .Center
        textField.autocapitalizationType = .AllCharacters
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        //clear default text when user use textfield, otherwise remain user's previous text content
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
        selectedTextField = textField
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //dismiss keyboard by touch any other area
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
//MARK: Keyboard Moving
    
    //When the keyboardWillShow notification is received, shift the view's frame up
    func keyboardWillShow(notification: NSNotification) {
        if selectedTextField == bottomTextField {
            view.frame.origin.y = getKeyboardHeight(notification) * (-1)
        }
    }
    //When the keyboardWillhide notification is received, shift the view's frame bakc down
    func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y < 0 {
            view.frame.origin.y = 0
        }
    }
    
    //helper to get keyboard height
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    //subscribe to keyboard show notification
    func subscribeToKeyboardShowNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    }
    //unsubscribe to keyboard show notification
    func unsubscribeToKeyboardShowNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    //subscribe to keyboard hide notification
    func subscribToKeyboardHideNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

//MARK: Select Image
    
    //pick image from camera button or album button
    @IBAction func pickImage(sender: UIBarButtonItem) {
        let imageVC = UIImagePickerController()
        imageVC.delegate = self
        if sender == cameraButton {
            imageVC.sourceType = .Camera
        } else {
            imageVC.sourceType = .PhotoLibrary
        }
        self.presentViewController(imageVC, animated: true, completion: nil)
    }
  
    //show image on ImageView
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] {
            pickedImageView.image = image as? UIImage
        }
        //enbale to share image
        shareButton.enabled = true
        dismissViewControllerAnimated(true, completion: nil)
    }
    
//MARK: Generate Memed Image
    func generateMemedImage() -> UIImage {
        //Hide toolbar and navbar
        topNaviBar.hidden = true
        bottomToolBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Show toolbar and navbar
        topNaviBar.hidden = false
        bottomToolBar.hidden = false
        
        return memedImage
    }

//MARK: share memedImage
    
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        memedImage = generateMemedImage()
        let shareVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        shareVC.completionWithItemsHandler = {
            (activity: String?, completed: Bool, items: [AnyObject]?, error: NSError?) in
            if completed {
                self.saveMeme()
                print("shoud save meme")
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        presentViewController(shareVC, animated: true, completion: nil)
    }
    
//MARK: Save MemeImage
    func saveMeme() {
        let meme = Meme(topText: self.topTextField.text!, bottomText: self.bottomTextField.text!, originImage: self.pickedImageView.image!, editImage: memedImage)
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        print("meme Saved, memes count" + "\(appDelegate.memes.count)")
        
    }
    
//MARK: cancel

    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        pickedImageView.image = UIImage()
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        shareButton.enabled = false
        dismissViewControllerAnimated(true, completion: nil)
    }

}

