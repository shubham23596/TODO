//
//  CategoryViewController.swift
//  TODO
//
//  Created by shubham jain on 12/05/18.
//  Copyright © 2018 shubham jain. All rights reserved.
//

import UIKit
import RealmSwift
class CategoryViewController: UITableViewController {
    let realm = try! Realm()
    var itemArry : Results<Category>?
   

    override func viewDidLoad() {
        super.viewDidLoad()
        LoadItems()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArry?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")
        cell?.textLabel?.text = itemArry?[indexPath.row].name ?? "no ctegories added"
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = itemArry?[indexPath.row]
        }
      
    }
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            //print(textField.text)
            let newIem = Category()
            newIem.name = textField.text!
           // self.itemArry.append(newIem)
            
            self.saveItems(category: newIem)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Task"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems(category: Category){
        
        do {
            try realm.write {
              realm.add(category)
            }
        }
        catch{
            print("error saving context, \(error)")
        }
        self.tableView.reloadData()
    }
    func LoadItems(){
        
       itemArry = realm.objects(Category.self)
        tableView.reloadData()
    }
}
