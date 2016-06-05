//
//  SentMemeCollectionViewController.swift
//  MemeMe
//
//  Created by Yang Ji on 5/26/16.
//  Copyright © 2016 Yang Ji. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SentMemeCollectiveCell"

class SentMemeCollectionViewController: UICollectionViewController {
    
//    //TODO: adjust flowlayout
//    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        //flow layout
//        let space: CGFloat = 3.0
//        let dimension = view.frame.size.width - (2*space) / 3.0
//        
//        flowLayout.minimumLineSpacing = space
//        flowLayout.minimumInteritemSpacing = space
//        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
        

    }
    
    override func viewWillAppear(animated: Bool) {
        collectionView?.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SentMemeCollectionViewCell
        
    
        // Configure the cell
        cell.imageView.image = memes[indexPath.item].editImage
        
        return cell
    }
    
    //select item sent to the matched detail view controller
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let meme = memes[indexPath.item]
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("detailVC") as! MemeDetailViewController
        detailVC.meme = meme
        navigationController?.pushViewController(detailVC, animated: true)
    }

    //MARK: Turn to EditMemeViewController

    @IBAction func pressAddBarButton(sender: UIBarButtonItem) {
        let addMemeVC = storyboard?.instantiateViewControllerWithIdentifier("addMemeVC")
        presentViewController(addMemeVC!, animated: true, completion: nil)
    }
    
}
