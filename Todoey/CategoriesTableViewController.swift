//
//  CategoriesTableViewController.swift
//  Todoey
//
//  Created by Isa  Selimi on 09/08/2019.
//  Copyright © 2019 com.isaselimi. All rights reserved.
//

import UIKit
import CoreData

class CategoriesTableViewController: UITableViewController {

    var categoriesArray : [Category] = [Category]()
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()    
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let category =  categoriesArray[indexPath.row]
        cell.textLabel?.text = category.title
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoriesArray.count
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        alert.addTextField{
            (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add category", style: .default) {
            (action) in
            let item = Category(context: self.context)
            item.title = textField.text!
            self.categoriesArray.append(item)
            self.saveCategories()
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func saveCategories(){
        do{
            try context.save()
        }catch {
            print("Error saving data -- \(error)")
        }
    }
    
    func loadCategories(){
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            try categoriesArray = context.fetch(request)
        }
        catch {
            print(error)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems" {
            let destinationViewController = segue.destination as! TodoListViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationViewController.selectedCategory = categoriesArray[indexPath.row]
            }
        }
    }
}
