//
//  ViewController.swift
//  TODO
//
//  Created by shubham jain on 03/05/18.
//  Copyright © 2018 shubham jain. All rights reserved.
//

import UIKit
import CoreData
class ToDoListViewController: UITableViewController, UISearchBarDelegate {
var itemArry = [item]()
    var selectedCategory : Category?{
        didSet{
            LoadItems()
        }
    }
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    override func viewDidLoad() {
        super.viewDidLoad()
       // let newItem = item(context: context)
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
    // Mark: Add new Items
    @IBAction func addNewItems(_ sender: UIBarButtonItem) {
        
 
           var textField = UITextField()
        let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            //print(textField.text)
            let newIem = item(context: self.context)
            newIem.title = textField.text!
            newIem.done = false
            newIem.parentCategory = self.selectedCategory
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
    func LoadItems(with request: NSFetchRequest<item> = item.fetchRequest(), predicate: NSPredicate? = nil){
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        }else {
            request.predicate = categoryPredicate
        }
       // let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
       
        do {
             itemArry = try context.fetch(request)
        }
        catch{
            print("error in fetching data\(error)")
        }
        tableView.reloadData()
    }
    //Mark: search bar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("button clicked")
        let request : NSFetchRequest<item> = item.fetchRequest()
      let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
       LoadItems(with: request, predicate: predicate)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text?.count == 0){
            LoadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}

