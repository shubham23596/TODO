//
//  ViewController.swift
//  TODO
//
//  Created by shubham jain on 03/05/18.
//  Copyright © 2018 shubham jain. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
var itemArry = [item]()
    let userDefault = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        let  newItem = item()
        newItem.title = "Let's add your tasks"
        itemArry.append(newItem)
        if let items = userDefault.array(forKey: "ToDoListArray") as? [item]{
            itemArry = items
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArry.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell")
        let item = itemArry[indexPath.row]
        cell?.textLabel?.text = item.title
        cell?.accessoryType = item.done == true ? .checkmark : .none
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArry[indexPath.row].done = !itemArry[indexPath.row].done
    tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // Mark: Add new items
    @IBAction func addNewItems(_ sender: UIBarButtonItem) {
        let newIem = item()
         var textField = UITextField()
        newIem.title = textField.text!
       self.itemArry.append(newIem)
        let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            //print(textField.text)
          
            self.userDefault.set(self.itemArry, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Task"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

