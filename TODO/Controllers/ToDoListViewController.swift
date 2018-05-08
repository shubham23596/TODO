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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    override func viewDidLoad() {
        super.viewDidLoad()
        let  newItem = item()
        newItem.title = "Let's add your tasks"
        itemArry.append(newItem)
      LoadItems()
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
        self.saveItems()

        tableView.deselectRow(at: indexPath, animated: true)
    }
    // Mark: Add new items
    @IBAction func addNewItems(_ sender: UIBarButtonItem) {
        
 
           var textField = UITextField()
        let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            //print(textField.text)
        let newIem = item()
            newIem.title = textField.text!
            self.itemArry.append(newIem)
            self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Task"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func saveItems(){
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArry)
            try data.write(to: dataFilePath!)
        }
        catch{
            print("error encoding item array, \(error)")
        }
        self.tableView.reloadData()
    }
    func LoadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                itemArry = try decoder.decode([item].self, from: data)
            } catch{
                print("error\(error)")
            }
        }
    }
}

