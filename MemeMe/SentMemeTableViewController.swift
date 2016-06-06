//
//  SentMemeTableViewController.swift
//  MemeMe
//
//  Created by Yang Ji on 5/26/16.
//  Copyright © 2016 Yang Ji. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UITableViewController {
    
    private let reuseIdentiferCell = "sentMemeTableViewCell"
    
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
    
    //select the cell transfer to detail view controller
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let meme = memes[indexPath.row]
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("detailVC") as! MemeDetailViewController
        
        detailVC.meme = meme
     
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //delete row
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            print(indexPath.row)
            removeMemeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }

    // MARK: - Navigation bar button item

    @IBAction func addMemeBarButtonItemPressed(sender: UIBarButtonItem) {
        let addMemeVC = storyboard?.instantiateViewControllerWithIdentifier("addMemeVC")
        presentViewController(addMemeVC!, animated: true, completion: nil)
    }
    
    //MARK: Helper
    //TODO: removeMEME
    func removeMemeAtIndex(index: Int) {
        let object = UIApplication.sharedApplication().delegate as! AppDelegate
        object.memes.removeAtIndex(index)
        //memes.removeAtIndex(index)
    }
}
