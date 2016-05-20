//
//  ViewController.swift
//  MemeMe
//
//  Created by Yang Ji on 5/19/16.
//  Copyright © 2016 Yang Ji. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var pickedImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    var selectedTextField: UITextField!
    
//MARK: Text Field Attributes
    let memeTextFieldAttributes: [String: AnyObject] = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: CGFloat(4.0)
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        topTextField.delegate = self
        topTextField.defaultTextAttributes = memeTextFieldAttributes
        topTextField.textAlignment = .Center
        bottomTextField.delegate = self
        bottomTextField.defaultTextAttributes = memeTextFieldAttributes
        bottomTextField.textAlignment = .Center

    }
    
    override func viewWillAppear(animated: Bool) {
        //check if camera device availabe
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
    }
    
//MARK: Text Field configure
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        textField.text = ""
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
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    


}

