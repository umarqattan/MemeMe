//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Umar Qattan on 6/14/15.
//  Copyright (c) 2015 Umar Qattan. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    var memes:[Meme] = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        self.collectionView?.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return count(self.memes)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("SentMemesCollectionViewCell", forIndexPath: indexPath) as! SentMemesCollectionViewCell
        var meme = self.memes[indexPath.row]
        if let image = meme.memedImage
        {
            cell.sentMemesImageView?.image = image
        }
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let memeViewController = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        memeViewController.meme = self.memes[indexPath.row]
        self.navigationController?.pushViewController(memeViewController, animated: true)
    }
    
    
    
    
}
