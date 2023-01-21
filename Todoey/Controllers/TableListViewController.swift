//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TableListViewController: UITableViewController {
    
    var todoArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        if let items = self.defaults.array(forKey: "todoArray") as? [String] {
        //            self.todoArray = items
        //        }
        
        let newItem = Item()
        newItem.title = "Find Mike"
        
        let newItem2 = Item()
        newItem2.title = "buy eggos"
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        
        todoArray.append(newItem)
        todoArray.append(newItem2)
        todoArray.append(newItem3)
    }
    
    //MARK UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = todoArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        todoArray[indexPath.row].done = !todoArray[indexPath.row].done
        
        tableView.reloadData()
    }
    
    //MARK Add new items
    
    @IBAction func addTodo(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { action in
            let newITem = Item()
            newITem.title = textField.text!
            
            self.todoArray.append(newITem)
            
            self.defaults.set(self.todoArray, forKey: "todoArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

