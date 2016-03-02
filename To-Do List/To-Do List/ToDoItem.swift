//
//  ToDoItem.swift
//  To-Do List
//
//  Created by Vishal Satish on 2/26/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class ToDoItem: NSObject, NSCoding {

    var toDoMessage: String
    var completed: Bool
    var completionDate: NSDate
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("toDoItems")
    
    // MARK: Types
    
    struct PropertyKey {
        static let toDoMessageKey = "toDoMessage"
        static let completedKey = "completed"
        static let completionDateKey = "completionDate"
    }
    
    init(toDoMessage: String, completed: Bool, completionDate: NSDate) {
        self.toDoMessage = toDoMessage
        self.completed = completed
        self.completionDate = completionDate
        
        super.init()
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(toDoMessage, forKey: PropertyKey.toDoMessageKey)
        aCoder.encodeObject(completed, forKey: PropertyKey.completedKey)
        aCoder.encodeObject(completionDate, forKey: PropertyKey.completionDateKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let toDoMessage = aDecoder.decodeObjectForKey(PropertyKey.toDoMessageKey) as! String
        let completed = aDecoder.decodeObjectForKey(PropertyKey.completedKey) as! Bool
        let completionDate = aDecoder.decodeObjectForKey(PropertyKey.completionDateKey) as! NSDate
        self.init(toDoMessage: toDoMessage, completed: completed, completionDate: completionDate)
    }
}
