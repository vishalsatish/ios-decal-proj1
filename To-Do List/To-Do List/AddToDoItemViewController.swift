//
//  AddToDoItemViewController.swift
//  To-Do List
//
//  Created by Vishal Satish on 2/26/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class AddToDoItemViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var toDoText: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var toDoItem: ToDoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 250.0/255.0, green: 247.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, self.toDoText.frame.height))
        toDoText.leftView = paddingView
        toDoText.leftViewMode = UITextFieldViewMode.Always
        toDoText.becomeFirstResponder()
        toDoText.delegate = self
        checkValidToDoText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UITextFieldDelegate
    
    // Hide the keyboard.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidToDoText()
        navigationItem.title = textField.text
    }
    
    // Disable the Save button while editing.
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    
    // Disable the Save button if the text field is empty.
    func checkValidToDoText() {
        let text = toDoText.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            toDoItem = ToDoItem(toDoMessage: toDoText.text ?? "", completed: false, completionDate: NSDate())
        }
    }

}
