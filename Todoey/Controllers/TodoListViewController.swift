//
//  ViewController.swift
//  Todoey
//
//  Created by Tono Purwanto on 25/01/18.
//  Copyright © 2018 Tono Purwanto. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Todo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todo1 = Todo()
        todo1.title = "Fide Mide"
        itemArray.append(todo1)
        
        let todo2 = Todo()
        todo2.title = "Buy Eggos"
        itemArray.append(todo2)
        
        let todo3 = Todo()
        todo3.title = "Destroy Demogorgon"
        itemArray.append(todo3)
    }
    
    // MARK - TableView Datasource Methods
    // ###################################
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let todo = itemArray[indexPath.row]
        
        cell.textLabel?.text = todo.title
        cell.accessoryType = todo.done ? .checkmark : .none
        
        return cell
    }
    
    // MARK - TableView Delegate Methos
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (alert) in
            let newTodo = Todo()
            newTodo.title = textField.text!
            
            self.itemArray.append(newTodo)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

