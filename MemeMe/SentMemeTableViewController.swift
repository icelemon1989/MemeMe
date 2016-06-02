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
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentiferCell, forIndexPath: indexPath) as! SentMemeTableViewCell
        
        // Configure the cell...
        let meme = memes[indexPath.row]
        
        cell.tableViewImage.image = meme.editImage
        cell.tableViewTopLabel.text = meme.topText
        cell.tabelViewBottomLabel.text = meme.bottomText
        
        return cell
    }

    @IBAction func addMemeBarButtonItemPressed(sender: UIBarButtonItem) {
        let addMemeVC = storyboard?.instantiateViewControllerWithIdentifier("addMemeVC")
        presentViewController(addMemeVC!, animated: true, completion: nil)
    }
}
