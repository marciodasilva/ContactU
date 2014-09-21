//
//  Contact.swift
//  ContactU
//
//  Created by MARCIO DASILVA on 8/3/14.
//  Copyright (c) 2014 Training. All rights reserved.
//

import Foundation
import CoreData

@objc(Contact)
class Contact: NSManagedObject {

    @NSManaged var contactImage: NSData
    @NSManaged var email: String
    @NSManaged var firstName: String
    @NSManaged var identifier: String
    @NSManaged var lastName: String
    @NSManaged var phone: String
    @NSManaged var toDoItem: NSSet

}
