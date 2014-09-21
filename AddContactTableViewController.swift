//
//  AddContactTableViewController.swift
//  ContactU
//
//  Created by MARCIO DASILVA on 8/3/14.
//  Copyright (c) 2014 Training. All rights reserved.
//

import UIKit
import CoreData

class AddContactTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var firstNameTextField : UITextField! = UITextField()
    @IBOutlet var lastNameTextField : UITextField! = UITextField()

    @IBOutlet var emailTextField : UITextField! = UITextField()

    @IBOutlet var phoneTextField : UITextField! = UITextField()

    @IBOutlet var contactImageView : UIImageView! = UIImageView()
    
    //init(style: UITableViewStyle) {
    //    super.init(style: style)
    //    // Custom initialization
    //}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "chooseImage:")
        tapGestureRecognizer.numberOfTapsRequired = 1
        contactImageView.addGestureRecognizer(tapGestureRecognizer)
        contactImageView.userInteractionEnabled=true
    }
    
    func chooseImage(recognizer:UITapGestureRecognizer){
        let imagePicker:UIImagePickerController=UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType=UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: NSDictionary!) {
        
        let pickedImage:UIImage = info.objectForKey(UIImagePickerControllerOriginalImage) as UIImage
        
        // small picture
        let smallPicture = scaleImageWith(pickedImage, newSize: CGSizeMake(100, 100))
        
        
        var sizeOfImageView:CGRect = contactImageView.frame
        sizeOfImageView.size = smallPicture.size
        contactImageView.frame = sizeOfImageView
        
        contactImageView.image = smallPicture
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!){
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scaleImageWith(image:UIImage, newSize:CGSize)->UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    @IBAction func addContact(sender : AnyObject) {
        let moc:NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        
        var contact:Contact = SwiftCoreDataHelper.insertManagedObject(NSStringFromClass(Contact), managedObjectConect: moc) as Contact
        
        contact.identifier = "\(NSDate())"
        contact.firstName = firstNameTextField.text
        contact.lastName = lastNameTextField.text
        contact.email = emailTextField.text
        contact.phone = phoneTextField.text
        
        let contactImageData:NSData = UIImagePNGRepresentation(contactImageView.image)
        
        contact.contactImage = contactImageData
        
        SwiftCoreDataHelper.saveManagedObjectContext(moc)
        
        self.navigationController!.popViewControllerAnimated(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
