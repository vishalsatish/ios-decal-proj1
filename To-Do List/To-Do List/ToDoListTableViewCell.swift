//
//  ToDoListTableViewCell.swift
//  To-Do List
//
//  Created by Vishal Satish on 2/26/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class ToDoListTableViewCell: UITableViewCell {

    @IBOutlet weak var toDoItemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
