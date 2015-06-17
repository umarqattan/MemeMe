//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Umar Qattan on 6/14/15.
//  Copyright (c) 2015 Umar Qattan. All rights reserved.
//

import Foundation
import UIKit


class SentMemesTableViewController:UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        var nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Default
    }
    
    /**
        Whenever the view controller appears, the memes
        array grows.
    */
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    /** 
        Tells the delegate that produces the tableView
        how many memes are in the shared model object:
        memes:[Meme]
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return count((UIApplication.sharedApplication().delegate as! AppDelegate).memes)
    }
    
    /**
        Returns a custom UITableViewCell with a memedImage imageView object
        and a UILabel with its top and bottom text.
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier("SentMemesTableViewCell") as! SentMemesTableViewCell
        var meme = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row]
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
        memeViewController.meme = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row]
        navigationController?.pushViewController(memeViewController, animated: true)
    }
<<<<<<< HEAD
    
    /**
        Enables the tableView to be edited (e.g. a left swipe on any
        particular row allows the user to delete it).
    */
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    /**
        Deletes the row from the tableView and from the shared model
        object in the AppDelegate.swift file.
    */
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            println("the row to be deleted is \(indexPath.row)\n")
            (UIApplication.sharedApplication().delegate as! AppDelegate).memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    
    
    
    
    
    
    
    
=======
>>>>>>> 99d2aaeadac2cb0cb87a868095cd49f90af62225
}
