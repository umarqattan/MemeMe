//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Umar Qattan on 6/14/15.
//  Copyright (c) 2015 Umar Qattan. All rights reserved.
//

import Foundation
import UIKit


class MemeDetailViewController:UIViewController
{
    @IBOutlet weak var memeDetailImageView: UIImageView!
    var meme: Meme!
    
    /**
        Simply displays the imageView object with the memedImage
        passed from either the SentMemesTableViewController or 
        the SentMemesCollectionViewController.
    */
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        if let image = meme.memedImage
        {
            memeDetailImageView.image = image
        }
    }
}