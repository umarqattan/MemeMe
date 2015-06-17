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
    var meme:Meme!
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        if let image = self.meme.memedImage
        {
            self.memeDetailImageView.image = image
        }
    }
    
    
}