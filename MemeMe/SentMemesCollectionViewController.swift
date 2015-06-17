//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Umar Qattan on 6/14/15.
//  Copyright (c) 2015 Umar Qattan. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    /**
    Whenever the view controller appears, the memes
    array grows.
    */
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }

    /** Tells the delegate that produces the tableView
    how many memes are in the shared model object:
    memes:[Meme]
    */
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return count((UIApplication.sharedApplication().delegate as! AppDelegate).memes)
    }
    
    /**
    Returns a custom UICollectionViewCell with a memedImage 
    imageView object with its top and bottom text embedded.
    */
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("SentMemesCollectionViewCell", forIndexPath: indexPath) as! SentMemesCollectionViewCell
        var meme = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row]
        if let image = meme.memedImage
        {
            cell.sentMemesImageView?.image = image
        }
        return cell
    }
    
    /**
    Whenever a row is selected, a MemeDetailViewController is pushed
    onto the navigationController stack.
    */
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let memeViewController = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        memeViewController.meme = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row]
        navigationController?.pushViewController(memeViewController, animated: true)
    }
}
