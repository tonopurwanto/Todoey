//
//  ViewController.swift
//  Todoey
//
//  Created by Tono Purwanto on 25/01/18.
//  Copyright © 2018 Tono Purwanto. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    let realm = try! Realm()
    
    var todos: Results<Todo>?
    
    var selectedCategory: Category? {
        didSet {
            loadTodos()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - TableView Datasource Methods
    /***************************************************************/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let todo = todos?[indexPath.row] {
            cell.textLabel?.text = todo.title
            cell.accessoryType = todo.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Todos Added Yet"
        }
        
        return cell
    }
    
    // MARK: - TableView Delegate Methos
    /***************************************************************/
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let todo = todos?[indexPath.row] {
            do {
                try realm.write {
                    todo.done = !todo.done
                }
            } catch {
                print("Error updating todo, \(error)")
            }
            
            tableView.reloadData()
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add New Items
    /***************************************************************/
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (alert) in
            if let category = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newTodo = Todo()
                        newTodo.title = textField.text!
                        newTodo.dateCreated = Date()
                        category.todos.append(newTodo)
                    }
                    
                } catch {
                    print("Error saving new todo, \(error)")
                }
            }
            
            self.tableView.reloadData()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Model Manipulation Methods
    /***************************************************************/
    
    func loadTodos(predicate: NSPredicate? = nil) {
        todos = selectedCategory!.todos.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }

}

// MARK: - SearchBar Methods
/***************************************************************/

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todos = todos?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadTodos()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}
