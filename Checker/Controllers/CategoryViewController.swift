//
//  CategoryViewController.swift
//  Checker
//
//  Created by Nicholas Els on 2022/04/27.
//

import UIKit
import CoreData
import Realm
import RealmSwift


class CategoryViewController: UITableViewController {

    
    let realm = try! Realm()
    var categories : Results<Category>?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
    }

    
    //MARK: TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        
        return cell
    }
    
    //MARK: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "GoToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoViewConrtoller
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: TableView Manipulation Methods
    
    func save(category : Category){
        
        do{
            try realm.write {
                
                realm.add(category)
                
            }
        }catch{
           print("Error saving category\(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategories() {
        
    categories = realm.objects(Category.self)
        
        
        tableView.reloadData()
    }
    
    
    
    //MARK: Add New Categories
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Checker Category", message: "", preferredStyle: .alert )
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
        
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
            
        }
        
        alert.addAction(action)
        
        alert.addTextField{(field) in
                textField = field
            textField.placeholder = "Add new Category"
            
        }
       
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
}
