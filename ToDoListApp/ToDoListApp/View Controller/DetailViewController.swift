//
//  DetailViewController.swift
//  ToDoListApp
//
//  Created by Admin on 9/28/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var item: Item?
    var itemIndex: Int?
    var listIndex: Int?
    
    @IBOutlet weak var itemDescriptionTextView: UITextView!
    
    // MARK: - View Life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If the current item has title, set it as the page title.
        guard let itemTitle = item?.title  else { return }
        self.title = "\(itemTitle)"
        
        // If the current item has detail, set it as the text view's text.
        guard let itemDetail = item?.detail  else { return }
        self.itemDescriptionTextView.text = "\(itemDetail)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Event handlers
    
    @IBAction func saveButtonDidTap(_ sender: UIBarButtonItem) {
        
        // Read the list from cache.
        let list = CacheController.readListFromCache(listIndex!) as List!
        
        // Get the item at `itemIndex` within the items array and update the `detail` with the text from the `itemDescriptionTextView`.
        let item = list?.items[itemIndex!] as Item!
        item?.detail = self.itemDescriptionTextView.text
        
        // Save the item back into the items array.
        list?.items[itemIndex!] = item!
        
        // Update the cache.
        CacheController.writeListToCache(list!, index: listIndex!)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
