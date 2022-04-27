//
//  ViewController.swift
//  Checker
//
//  Created by Nicholas Els on 2022/04/26.
//

import UIKit
import CoreData

class ToDoViewConrtoller: UITableViewController{

    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    
        loadItems()
        
    }
        // Do any additional setup after loading the view.

// MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        print("cellforRowIndexPath")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    
    }
        //MARK -TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        
     //   print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItmes()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        
    }
    
    //MARK - Add New Item

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Checker Item", message: "", preferredStyle: .alert )
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in 
        
            // What will happen when the user clicks the add Item button on our UIAlert
           
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            
            self.saveItmes()
            
    }
        
        alert.addTextField{(alertTextField) in
            alertTextField.placeholder = "Create new item"
           textField = alertTextField
       
        }
       
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
}
    
    func saveItmes(){
       
        do {
            try context.save()
        }catch{
          print("Error Saving context \(error)")
            
        }
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
   
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
}
//MARK: - Search Bar Methods

extension ToDoViewConrtoller: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS %@", searchBar.text!)
        
        request.sortDescriptors  = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
            loadItems()
            
            DispatchQueue.main.async {
                
                searchBar.resignFirstResponder()
                
            }
        }
    }
    
    
}
