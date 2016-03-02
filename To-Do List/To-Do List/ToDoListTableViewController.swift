//
//  ToDoListTableViewController.swift
//  To-Do List
//
//  Created by Vishal Satish on 2/26/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    
    var toDoItems = [ToDoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        if let savedToDoItems = loadToDoItems() {
            for (index, item) in savedToDoItems.enumerate() {
                if item.completed {
                    if (NSCalendar.currentCalendar().components(.Hour, fromDate: item.completionDate, toDate: NSDate(), options: []).hour) >= 24 {
                        continue
                    }
                }
                toDoItems += [savedToDoItems[index]]
            }
            saveToDoItems()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoListTableViewCell", forIndexPath: indexPath) as! ToDoListTableViewCell
        let toDoItem = toDoItems[indexPath.row]
        cell.toDoItemLabel.text = toDoItems[indexPath.row].toDoMessage
        if toDoItem.completed{
            cell.accessoryType = .Checkmark
            cell.toDoItemLabel.textColor = UIColor.lightGrayColor()
        } else {
            cell.toDoItemLabel.textColor = UIColor.blackColor()
            cell.accessoryType = .None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
            let tappedItem = toDoItems[indexPath.row]
            tappedItem.completed = !tappedItem.completed
            tappedItem.completionDate = NSDate()
            saveToDoItems()
            tableView.reloadData()
    }
    
    // Delete the row from the data source
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            toDoItems.removeAtIndex(indexPath.row)
            saveToDoItems()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    @IBAction func unwindToToDoListTableViewController(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddToDoItemViewController, toDoItem = sourceViewController.toDoItem {
            let newIndexPath = NSIndexPath(forRow: toDoItems.count, inSection: 0)
            toDoItems.append(toDoItem)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
        saveToDoItems()
    }


    // MARK: NSCoding
    
    func saveToDoItems() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(toDoItems, toFile: ToDoItem.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save To-Do items...")
        }
    }
    
    func loadToDoItems() -> [ToDoItem]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(ToDoItem.ArchiveURL.path!) as? [ToDoItem]
    }
    
}

