//
//  SentMemeTableViewController.swift
//  MemeMe
//
//  Created by Yang Ji on 5/26/16.
//  Copyright © 2016 Yang Ji. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UITableViewController {
    
    let reuseIdentiferCell = "sentMemeTableViewCell"
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }

    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentiferCell, forIndexPath: indexPath)
        
        // Configure the cell...
        let meme = memes[indexPath.row]
        
        cell.imageView?.image = meme.editImage
        cell.textLabel?.text = meme.topText
        cell.detailTextLabel?.text = meme.bottomText
        
        return cell
    }

    @IBAction func editBarButtonItemPressed(sender: UIBarButtonItem) {
        let editMemeVC = storyboard?.instantiateViewControllerWithIdentifier("editMemeVC")
        presentViewController(editMemeVC!, animated: true, completion: nil)
    }
}
