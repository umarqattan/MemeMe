//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Umar Qattan on 6/14/15.
//  Copyright (c) 2015 Umar Qattan. All rights reserved.
//

import Foundation
import UIKit


class MemeEditorViewController:UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var top: UITextField!
    @IBOutlet weak var bottom: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    /** Set delegates for global outlets **/
        top.delegate = self
        bottom.delegate = self
        shareButton.enabled = false
        top.enabled = false
        bottom.enabled = false
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -4.0
        ]
        
        top.defaultTextAttributes = memeTextAttributes
        bottom.defaultTextAttributes = memeTextAttributes
        
        
    /**
        I had so much trouble trying to figure out
        why my UITextfield objects were not displa-
        yed over the UIImageView. I simply placed
        them at the bottom of the UIView hierarchy
        in Main.storyboard. Below is a link to my
        source of inspiration:
        http://stackoverflow.com/questions/7402677/how-do-you-show-uilabel-over-a-uiimageview-objective-c
    */

        top.text = "TOP"
        bottom.text = "BOTTOM"
        top.textAlignment = .Center
        bottom.textAlignment = .Center
    }
    
    
    
    @IBAction func cancel(sender: UIBarButtonItem)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
        In order for the share button to be tapped,
        it must be enabled. For it to be enabled,
        the user must have either chosen an image from
        the photo album or taken a picture using the
        camera. If the method save: completes
        successfully, the MemeEditorViewController
        dismisses itself.

    */
    @IBAction func share(sender: UIBarButtonItem)
    {
        var meme = generateMemedImage()
        var activityViewController = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            if success
            {
                self.save()
                self.dismissViewControllerAnimated(true, completion:nil)
            }
        }
        presentViewController(activityViewController, animated: true, completion:nil)
    }
    
    /**
        hideToolBars: is a simple method to toggle the
        appearence of the top and bottom UIToolbars;
        that is, make them either hidden or visible.
    */
    func hideToolBars(hide:Bool) -> Void
    {
        if hide == true
        {
            topToolBar.hidden = true
            bottomToolBar.hidden = true
        }
        else
        {
            topToolBar.hidden = false
            bottomToolBar.hidden = false
        }
    }
    
    func generateMemedImage() -> UIImage
    {
        hideToolBars(true)
        
    /** Begin Image Context **/
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
    /** End Image Context **/
        UIGraphicsEndImageContext()
        hideToolBars(false)
        return memedImage
    }
    
    /**
        When the save: method is called within the
        completion handler of share:, it stores and
        appends the memed image to the shared model 
        object, memes, which is of type [Memes].
    */
    func save()
    {
        var meme = Meme(top: top.text, bottom: bottom.text, originalImage: imageView.image!, memedImage: generateMemedImage())
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications()
    {
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillShow:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillHide:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications()
    {
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name:UIKeyboardWillShowNotification,
            object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name:UIKeyboardWillHideNotification,
            object: nil)
    }
    
    /**
        If the bottom keyboard pops up, the view will 
        shift upward so that the text will be in view.
    */
    func keyboardWillShow(notification: NSNotification)
    {
        if bottom.isFirstResponder()
        {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    /**
        When the bottom keyboard is not in use,
        the view will shift downward to compensate
        for the upward shift earlier.
    */
    func keyboardWillHide(notification: NSNotification)
    {
        if bottom.isFirstResponder()
        {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }

    func getKeyboardHeight(notification: NSNotification) -> CGFloat
    {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    @IBAction func pickAnImageFromAlbum(sender: UIBarButtonItem)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            imageView.image = image
            imageView.userInteractionEnabled = true
            shareButton.enabled = true
            top.enabled = true
            bottom.enabled = true
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
        If the textField reads either TOP or BOTTOM, 
        then it will erase whatever is written in the
        textField.
    */
    func textFieldDidBeginEditing(textField: UITextField)
    {
        if (textField.text == "TOP" || textField.text == "BOTTOM")
        {
            textField.text = ""
        }
    }
    
    /**
        If the textField object has no text and is the
        top textField object, then its text will display
        TOP; if the textField object has no text and is the
        bottom textField object, then its text will display
        BOTTOM.
    */
    func textFieldDidEndEditing(textField: UITextField)
    {
        if (textField.text == "" && textField == top)
        {
            textField.text = "TOP"
        }
        if (textField.text == "" && textField == bottom)
        {
            textField.text = "BOTTOM"
        }
    }
    
    /**
        Whenever the Return key is tapped on the keyboard,
        the keyboard hides.
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}