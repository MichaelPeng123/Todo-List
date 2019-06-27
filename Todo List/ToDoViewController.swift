//
//  ViewController.swift
//  Todo List
//
//  Created by Michael Peng on 6/26/19.
//  Copyright © 2019 Michael Peng. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    
    
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    var itemArray = [item]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(dataFilePath)
        

//        if let items = defaults.array(forKey: "TodoListArray") as? [item] {
//            itemArray = items
//        }
        
        loadItems()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for : indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        self.saveItems()
        
    
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textEntered = UITextField()
        let alert = UIAlertController(title: "Add New Todey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
           let newItem = item()
            newItem.title = textEntered.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            

            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textEntered = alertTextField
        }
        alert.addAction(action)
        present(alert, animated:true, completion:nil)
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        
        do {
            let data = try encoder.encode(itemArray)
            
            try data.write(to: dataFilePath! )
            
        }
        catch {
            print("Error:  ,\(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            
            do {
                itemArray = try decoder.decode([item].self, from: data)
            }
            catch {
                print(error)
            }
            
        }
    }
    
    
    
    
}

