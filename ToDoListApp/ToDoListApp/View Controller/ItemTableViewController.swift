//
//  ItemTableViewController.swift
//  ToDoListApp
//
//  Created by Admin on 9/27/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
    
    var list: List?
    var listIndex: Int?
    
    // MARK: - View Life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the table view row height.
        self.tableView.rowHeight = 60
        
        // If the current list has title, set it as the page title.
        guard let listTitle = list?.name  else { return }
            self.title = "\(listTitle)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update the current list from the cache, everytime the page is shown.
        list = CacheController.readListFromCache(listIndex!)
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
        return (list?.items.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell

        // Configure the cell...
        let item = list?.items[indexPath.row]
        cell.itemNameLabel?.text = item?.title ?? ""
        cell.listIndex = listIndex
        cell.itemIndex = indexPath.row
        
        // Set the image based on the completion status of the item.
        let imageName = SelectionController.isCompletedItem(cell.listIndex!, itemIndex: cell.itemIndex!) ? "radio-button-on" : "radio-button-off"
        cell.optionButton.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete the row from the data source and update the cache.
            list?.items.remove(at: indexPath.row)
            CacheController.writeListToCache(list!, index: listIndex!)
            
            // Also, update the UI.
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Event handlers
    
    // Add new list item.
    @IBAction func addItemBarButtonTapped(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Item", message: "Insert the title of the item", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let title = alert.textFields?[0].text {
                if title.count > 0 {
                    self.addNewToDoListItem(title: title)
                    print("Add new item bar button pressed")
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addNewToDoListItem(title: String) {
        
        // Add to the items and update the cache.
        let newIndex = list?.items.count
        list?.items.append(Item(title: title, detail: ""))
        CacheController.writeListToCache(list!, index: listIndex!)
        
        // Also, update the UI.
        tableView.insertRows(at: [IndexPath(row: newIndex! , section: 0)], with: .automatic)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSaveItemsSegue" {
            // Get the new view controller using
            guard let detailViewController = segue.destination as? DetailViewController else { return }
            // Pass the selected object to the new view controller.
            guard let cell = sender as? ItemTableViewCell else { return }
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            let item = list?.items[indexPath.row]
            detailViewController.item = item
            detailViewController.listIndex = listIndex
            detailViewController.itemIndex = list?.items.index(of: item!)
        }
    }
}
