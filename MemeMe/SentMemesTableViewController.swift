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
        
        self.memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        self.tableView.reloadData()
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return count(self.memes)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier("SentMemesTableViewCell") as! SentMemesTableViewCell
        /**
            TODO: insert code to add details to the SentMemesTableViewCell object
        **/
        var meme                 = self.memes[indexPath.row]
        cell.memeLabel?.text     = meme.top + "..." + meme.bottom
        if let image = meme.memedImage
        {
            cell.memeImageView?.image = image
        }
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        /**
            TODO: insert code to initialize a MemeDetailViewController to view the
                  cell object.
        **/
        let memeViewController = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        memeViewController.meme = self.memes[indexPath.row]
        self.navigationController?.pushViewController(memeViewController, animated: true)
        
    }
    
    
    
    
    
    
    
    
    
}
