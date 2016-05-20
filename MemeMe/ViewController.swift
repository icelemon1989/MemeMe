//
//  ViewController.swift
//  MemeMe
//
//  Created by Yang Ji on 5/19/16.
//  Copyright © 2016 Yang Ji. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var pickedImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //check if camera device availabe
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
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

