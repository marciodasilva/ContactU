//
//  AddItemViewController.swift
//  ContactU
//
//  Created by MARCIO DASILVA on 8/3/14.
//  Copyright (c) 2014 Training. All rights reserved.
//

import UIKit
import CoreData


class AddItemViewController: UIViewController, ContactSelectionDelegate {

    @IBOutlet var contactImageView: UIImageView!=UIImageView()
    
    @IBOutlet var firstNameLabel: UILabel! = UILabel()
    
    @IBOutlet var lastNameLabel: UILabel! = UILabel()
    
    @IBOutlet var titleTextField: UITextField! = UITextField()
    
    @IBOutlet var datePicker: UIDatePicker! = UIDatePicker()
    
    var contactIdentifierString:NSString = NSString()
    var datePicked:NSDate = NSDate()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameLabel.text = "Your"
        lastNameLabel.text = "Contact"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func pickerChanged(sender: UIDatePicker) {
        
        datePicked = sender.date
    }
    
    
    @IBAction func done(sender: AnyObject) {
        
        let moc:NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        
        let predicate:NSPredicate = NSPredicate(format: "identifier == '\(contactIdentifierString)'")
        let results:NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Contact), withPredicate: predicate, managedObjectContext: moc)
        
        let contact:Contact = results.lastObject as Contact
        
        var toDoItem:ToDoItem = SwiftCoreDataHelper.insertManagedObject(NSStringFromClass(ToDoItem), managedObjectConect: moc) as ToDoItem
        
        toDoItem.identifier = "\(NSDate())"
        toDoItem.dueDate = datePicked
        toDoItem.note = titleTextField.text
        toDoItem.contact = contact
        
        SwiftCoreDataHelper.saveManagedObjectContext(moc)
        
        self.navigationController!.popViewControllerAnimated(true)
    }
  
    
    func userDidSelectContact(contactIdentifier: NSString) {
        contactIdentifierString = contactIdentifier
        
        let moc:NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        let predicate:NSPredicate = NSPredicate(format: "identifier == '\(contactIdentifier)'")
        let results:NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Contact), withPredicate: predicate, managedObjectContext: moc)
        
        let contact:Contact = results.lastObject as Contact
        contactImageView.image = UIImage(data: contact.contactImage)
        firstNameLabel.text = contact.firstName
        lastNameLabel.text = contact.lastName
        
        
    }
    
    
    
    // #pragma mark - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "contactsSegue"{
            let viewController:ContactsTableViewController = segue.destinationViewController as ContactsTableViewController
            
            viewController.delegate = self
            
        }
        
        
    }
    
    
}
