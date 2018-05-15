//
//  CategoryViewController.swift
//  TODO
//
//  Created by shubham jain on 12/05/18.
//  Copyright © 2018 shubham jain. All rights reserved.
//

import UIKit
import CoreData
class CategoryViewController: UITableViewController {
var itemArry = [Category]()
   
 let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadItems()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArry.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")
        let item = itemArry[indexPath.row]
        cell?.textLabel?.text = item.name
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = itemArry[indexPath.row]
        }
      
    }
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            //print(textField.text)
            let newIem = Category(context: self.context)
            newIem.name = textField.text!
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
        
        do {
            try context.save()
        }
        catch{
            print("error saving context, \(error)")
        }
        self.tableView.reloadData()
    }
    func LoadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        
        do {
            itemArry = try context.fetch(request)
        }
        catch{
            print("error in fetching data\(error)")
        }
        tableView.reloadData()
    }
}
