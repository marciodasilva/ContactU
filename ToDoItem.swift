//
//  ToDoItem.swift
//  ContactU
//
//  Created by MARCIO DASILVA on 8/3/14.
//  Copyright (c) 2014 Training. All rights reserved.
//

import Foundation
import CoreData

@objc(ToDoItem)
class ToDoItem: NSManagedObject {

    @NSManaged var dueDate: NSDate
    @NSManaged var identifier: String
    @NSManaged var note: String
    @NSManaged var contact: Contact

}
