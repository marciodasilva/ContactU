//
//  ContactsTableViewController.swift
//  ContactU
//
//  Created by MARCIO DASILVA on 8/3/14.
//  Copyright (c) 2014 Training. All rights reserved.
//

import UIKit
import CoreData
protocol ContactSelectionDelegate{
    func userDidSelectContact(contactIdentifier:NSString)
    
}
class ContactsTableViewController: UITableViewController {

    var yourContact:NSMutableArray = NSMutableArray()
    var delegate:ContactSelectionDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    
    func loadData(){
        yourContact.removeAllObjects()
        let moc:NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        let results:NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Contact), withPredicate: nil, managedObjectContext: moc)
        
        for contact in results{
            let singleContact:Contact = contact as Contact
            
            let contactDict:NSDictionary = ["identifier":singleContact.identifier,
                                            "firstName":singleContact.firstName,
                                            "lastName":singleContact.lastName,
                                            "email":singleContact.email,
                                            "phone":singleContact.phone,
                                            "contactImage":singleContact.contactImage]
            yourContact.addObject(contactDict)
        }
        
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return yourContact.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ContactCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as ContactCellTableViewCell
        
        let contactDict:NSDictionary = yourContact.objectAtIndex(indexPath.row) as NSDictionary
        
        let firstName    = contactDict.objectForKey("firstName") as String
        let lastName     = contactDict.objectForKey("lastName") as String
        let mail         = contactDict.objectForKey("email") as String
        let phone        = contactDict.objectForKey("phone") as String
        let imageData:NSData    = contactDict.objectForKey("contactImage") as NSData
        let contactImage:UIImage = UIImage(data: imageData)
        
        cell.nameLabel.text = firstName + " " + lastName
        cell.phoneLabel.text = phone
        cell.emailLabel.text = mail
        
        var contactImageFrame:CGRect = cell.contactImageView.frame
        contactImageFrame.size = CGSizeMake(75, 75)
        cell.contactImageView.frame = contactImageFrame
        cell.contactImageView.image = contactImage

        return cell
    }
  
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        if delegate != nil {
            let contactDict:NSDictionary = yourContact.objectAtIndex(indexPath.row) as NSDictionary
            delegate!.userDidSelectContact(contactDict.objectForKey("identifier") as NSString)
            
            self.navigationController!.popViewControllerAnimated(true)
        }
    }

    
}
