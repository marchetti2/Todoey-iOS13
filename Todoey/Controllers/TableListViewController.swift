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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.dataFilePath!)
        
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
        
        saveTodoData()
    }
    
    //MARK Add new items
    
    @IBAction func addTodo(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { action in
            let newITem = Item()
            newITem.title = textField.text!
            
            self.todoArray.append(newITem)
            
            self.saveTodoData()
            
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveTodoData() {
        let encoder = PropertyListEncoder()
        do {
            
            let data = try encoder.encode(todoArray)
            try data.write(to: dataFilePath!)
            
            self.tableView.reloadData()
            
        } catch {
            print("error encoding data \(error)")
        }
    }
    
}

