//
//  ListTableViewController.swift
//  ToDoListApp
//
//  Created by Admin on 9/27/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    // Array to hold all the lists.
    var lists: [List] = [
        List(name: "Groceries", items: [
            Item(title: "Visit Costco", detail: "Remember to take the membership card"),
            Item(title: "Visit Whole Foods", detail: "Remember to return the glass bottles for recycling."),
            Item(title: "Visit Farmer's Market", detail: "Remember to carry the reusable bags.")
            ]),
        List(name: "Party", items: [
            Item(title: "Visit Party City", detail: "Check for coupons."),
            Item(title: "Order party dress", detail: "Check Amazon.com and eBay.com"),
            Item(title: "Food preparation", detail: "Call the restaurants.")
            ]),
        List(name: "Vacation", items: [])
    ]
    
    // MARK: - View Life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the table view row height.
        self.tableView.rowHeight = 60
        
        // Set the edit button item.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update the lists array from the cache, everytime the page is shown.
        let cachedLists = CacheController.readListsFromCache()
        if (cachedLists.count > 0) {
            lists = cachedLists
        }
        else {
            CacheController.writeListsToCache(lists)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        
        // Configure the cell...
        let list = lists[indexPath.row]
        cell.titleLabel.text = list.name
        cell.index = indexPath.row
        
        // Set the image based on the completion status of the list.
        let imageName = SelectionController.isCompletedList(cell.index!) ? "radio-button-on" : "radio-button-off"
        cell.optionButton.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete the row from the data source and update the cache.
            lists.remove(at: indexPath.row)
            CacheController.writeListsToCache(lists)
            
            // Also, update the cache.
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Event handlers
    
    @IBAction func addBarButtonTapped(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New List", message: "Insert the title of the new list", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let title = alert.textFields?[0].text {
                if title.count > 0 {
                    self.addNewToDoListItem(title: title)
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addNewToDoListItem(title: String) {
        // Add to the lists and update the cache.
        let newIndex = lists.count
        lists.append(List(name: title, items: []))
        CacheController.writeListsToCache(lists)
        
        // Also, update the UI.
        tableView.insertRows(at: [IndexPath(row: newIndex , section: 0)], with: .automatic)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToListItemsSegue" {
            guard let itemViewController = segue.destination as? ItemTableViewController else { return }
            guard let cell = sender as? ListTableViewCell else { return }
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            let list = lists[indexPath.row]
            itemViewController.list = list
            itemViewController.listIndex = lists.index(of: list)
        }
    }
}
 
    

