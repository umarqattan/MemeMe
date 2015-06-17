//
//  Meme.swift
//  MemeMe
//
//  Created by Umar Qattan on 6/14/15.
//  Copyright (c) 2015 Umar Qattan. All rights reserved.
//

import Foundation
import UIKit

class Meme: NSObject
{
    var top:           String!
    var bottom:        String!
    var originalImage:UIImage!
    var memedImage:   UIImage!
    init(top:String, bottom:String, originalImage:UIImage, memedImage:UIImage )
    {
        self.top           = top
        self.bottom        = bottom
        self.originalImage = originalImage
        self.memedImage    = memedImage
    }
    
    
    
    
    
    
    
}