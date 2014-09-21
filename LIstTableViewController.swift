//
//  LIstTableViewController.swift
//  ContactU
//
//  Created by MARCIO DASILVA on 8/9/14.
//  Copyright (c) 2014 Training. All rights reserved.
//

import UIKit
import CoreData
import MessageUI

class ListTableViewController: UITableViewController, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    var toDoItems:NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        loadData()
        
    }
    
    func loadData(){
        toDoItems.removeAllObjects()
        
        let moc:NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        let results:NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(ToDoItem), withPredicate: nil, managedObjectContext: moc)
        
        if results.count > 0 {
            
            for toDo in results{
                let singleToDoItem:ToDoItem = toDo as ToDoItem
                
                let identifier = singleToDoItem.identifier
                
                let contact:Contact = singleToDoItem.contact
                
                let firstName = contact.firstName
                let lastName = contact.lastName
                let email = contact.email
                let phone = contact.phone
                
                let dueDate = singleToDoItem.dueDate
                let title = singleToDoItem.note
                
                let profileImage:UIImage = UIImage(data: contact.contactImage)
                
                let dict:NSDictionary = ["identifier":identifier,"firstName":firstName, "lastName":lastName, "email":email, "phone":phone, "dueDate":dueDate, "title":title, "profileImage":profileImage]
                
                toDoItems.addObject(dict)
                
                
            }
            
            let dateDescriptor:NSSortDescriptor = NSSortDescriptor(key: "dueDate", ascending: true)
            var sortedArray:NSArray = toDoItems.sortedArrayUsingDescriptors([dateDescriptor])
            
            toDoItems = NSMutableArray(array: sortedArray)
            
            
            self.tableView.reloadData()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // #pragma mark - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return toDoItems.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ListTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as ListTableViewCell
        
        
        let infoDict:NSDictionary = toDoItems.objectAtIndex(indexPath.row) as NSDictionary
        
        let firstName:NSString = infoDict.objectForKey("firstName") as NSString
        let lastName:NSString = infoDict.objectForKey("lastName") as NSString
        
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        
        let dateString:NSString = dateFormatter.stringFromDate(infoDict.objectForKey("dueDate") as NSDate)
        
        cell.contactImageView.image = infoDict.objectForKey("profileImage") as? UIImage
        cell.nameLabel.text = firstName + " " + lastName
        cell.titleLabel.text = infoDict.objectForKey("title") as NSString
        cell.dueDateLabel.text = dateString
        
        cell.callButton.tag = indexPath.row
        cell.textButton.tag = indexPath.row
        cell.mailButton.tag = indexPath.row
        
        cell.callButton.addTarget(self, action: "callSomeOne:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.textButton.addTarget(self, action: "textSomeOne:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.mailButton.addTarget(self, action: "mailSomeOne:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        return cell
    }
    
    
    func callSomeOne(sender:UIButton){
        let infoDict:NSDictionary = toDoItems.objectAtIndex(sender.tag) as NSDictionary
        
        let phoneNumber = infoDict.objectForKey("phone") as NSString
        
        UIApplication.sharedApplication().openURL(NSURL(string: "telprompt://\(phoneNumber)"))
        
    }
    
    func textSomeOne(sender:UIButton){
        let infoDict:NSDictionary = toDoItems.objectAtIndex(sender.tag) as NSDictionary
        let phoneNumber = infoDict.objectForKey("phone") as NSString
        
        if MFMessageComposeViewController.canSendText() {
            let messageController:MFMessageComposeViewController = MFMessageComposeViewController()
            messageController.recipients = ["\(phoneNumber)"]
            messageController.messageComposeDelegate = self
            
            self.presentViewController(messageController, animated: true, completion: nil)
            
        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        
        controller.dismissViewControllerAnimated(true, completion: nil)
        
        // Does not work in Beta 4
        /*switch result.value{
        case MessageComposeResultSent.value:
        controller.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultCancelled.value:
        controller.dismissViewControllerAnimated(true, completion: nil)
        default:
        controller.dismissViewControllerAnimated(true, completion: nil)
        }*/
        
        
    }
    
    
    func mailSomeOne(sender:UIButton){
        let infoDict:NSDictionary = toDoItems.objectAtIndex(sender.tag) as NSDictionary
        let email = infoDict.objectForKey("email") as NSString
        
        if MFMailComposeViewController.canSendMail() {
            let messageController:MFMailComposeViewController = MFMailComposeViewController()
            messageController.setToRecipients(["\(email)"])
            messageController.mailComposeDelegate = self
            
            self.presentViewController(messageController, animated: true, completion: nil)
            
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        
        controller.dismissViewControllerAnimated(true, completion: nil)
        
        // Does not work in Beta 4
        /*switch result.value{
        case MFMailComposeResultCancelled.value:
        controller.dismissViewControllerAnimated(true, completion: nil)
        case MFMailComposeResultSent.value:
        controller.dismissViewControllerAnimated(true, completion: nil)
        default:
        controller.dismissViewControllerAnimated(true, completion: nil)
        
        }*/
        
    }
    
    
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            if (toDoItems.count > 0){
                let infoDict:NSDictionary = toDoItems.objectAtIndex(indexPath.row) as NSDictionary
                
                let moc:NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
                
                let identifier:NSString = infoDict.objectForKey("identifier") as NSString
                
                let predicate:NSPredicate = NSPredicate(format: "identifier == '\(identifier)'")
                
                let results:NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(ToDoItem), withPredicate: predicate, managedObjectContext: moc)
                
                let toDoItemToDelete:ToDoItem = results.lastObject as ToDoItem
                
                toDoItemToDelete.managedObjectContext.deleteObject(toDoItemToDelete)
                
                SwiftCoreDataHelper.saveManagedObjectContext(moc)
                
                loadData()
                self.tableView.reloadData()
                
                
                
            }
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    
    
    
    
}
