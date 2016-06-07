//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Yang Ji on 6/2/16.
//  Copyright © 2016 Yang Ji. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme : Meme!

    @IBOutlet weak var detailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //load meme image
        detailImageView.image = meme.editImage
        
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(MemeDetailViewController.editMemeButtonPressed(_:)))
    }
    
    func editMemeButtonPressed(sender: UIBarButtonItem) {
        let addMemeVC = storyboard?.instantiateViewControllerWithIdentifier("addMemeVC") as! MemeEditorViewController
        addMemeVC.passedMeme = meme
        presentViewController(addMemeVC, animated: true, completion: nil)
    }


}
