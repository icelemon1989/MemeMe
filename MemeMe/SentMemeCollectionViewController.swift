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
    
    let memeLabelTextAttributes: [String: AnyObject] = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 18)!,
        NSStrokeWidthAttributeName: CGFloat(-4.0)
        
    ]
    
    //TODO: adjust flowlayout
    @IBOutlet weak var collectiveflowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //flow layout
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2*space)) / 3.0
        
        collectiveflowLayout.minimumLineSpacing = space
        collectiveflowLayout.minimumInteritemSpacing = space
        collectiveflowLayout.itemSize = CGSizeMake(dimension, dimension)
        
        

    }
    
    override func viewWillAppear(animated: Bool) {
        collectionView?.reloadData()
        
        collectionView?.backgroundColor = UIColor.whiteColor()
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
        let meme = memes[indexPath.item]
        cell.imageView.image = meme.originImage
        cell.top.text = meme.topText
        cell.bottom.text = meme.bottomText
        
        self.configureCellLabel(cell.top)
        self.configureCellLabel(cell.bottom)
        
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
    
    //MARK: Helper
    //configure the label attribute in cell
    func configureCellLabel(label: UILabel) {
        let attributeString = NSMutableAttributedString(string: label.text!, attributes: memeLabelTextAttributes)
        label.attributedText = attributeString
    }
    
}
