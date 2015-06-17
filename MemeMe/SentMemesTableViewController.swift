//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Umar Qattan on 6/14/15.
//  Copyright (c) 2015 Umar Qattan. All rights reserved.
//

import Foundation
import UIKit


class SentMemesTableViewController:UITableViewController, UITableViewDelegate, UITableViewDataSource
{
    var memes:[Meme] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        var nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Default
        memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    /**
        Whenever the view controller appears, the memes
        array grows.
    */
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        tableView.reloadData()
    }
    
    /** Tells the delegate that produces the tableView
        how many memes are in the shared model object:
        memes:[Meme]
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
    
        return count(memes)
    }
    
    /**
        Returns a custom UITableViewCell with a memedImage imageView object
        and a UILabel with its top and bottom text.
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier("SentMemesTableViewCell") as! SentMemesTableViewCell
        var meme = memes[indexPath.row]
        cell.memeLabel?.text = meme.top + "..." + meme.bottom
        if let image = meme.memedImage
        {
            cell.memeImageView?.image = image
        }
        return cell
    }
    
    /**
        Whenever a row is selected, a MemeDetailViewController is pushed
        onto the navigationController stack.
    */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let memeViewController = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        memeViewController.meme = memes[indexPath.row]
        navigationController?.pushViewController(memeViewController, animated: true)
    }
}
