//
//  DailyStatsViewController.swift
//  To-Do List
//
//  Created by Vishal Satish on 2/26/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class DailyStatsViewController: UIViewController {

    @IBOutlet weak var tasksCompletedLabel: UILabel!
    var numCompleted = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 250.0/255.0, green: 247.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        if let savedToDoItems = loadToDoItems() {
            for item in savedToDoItems {
                if item.completed {
                    numCompleted += 1
                }
            }
        }
        tasksCompletedLabel.text = String(numCompleted)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadToDoItems() -> [ToDoItem]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(ToDoItem.ArchiveURL.path!) as? [ToDoItem]
    }
    
}
