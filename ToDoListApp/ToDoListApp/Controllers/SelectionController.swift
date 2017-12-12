//
//  SelectionController.swift
//  ToDoListApp
//
//  Created by Prabhu Bose on 9/28/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import UIKit

// Class to implement the logic for marking a list/ item as completed or not.
class SelectionController: NSObject {
    
    // MARK: - List Selection
    
    // Check if a list is completed or not.
    static func isCompletedList(_ index: Int) -> Bool {
        
        // Read the list from cache and check for the `isCompleted` property.
        let list = CacheController.readListFromCache(index)
        return list.isCompleted
    }
    
    // Mark a list as complete.
    static func markListAsComplete(_ index: Int) {
        
        // Read the list from cache.
        let list = CacheController.readListFromCache(index)
        
        // Mark the list as complete.
        list.isCompleted = true
        
        // Update the cache.
        CacheController.writeListToCache(list, index: index)
    }
    
    // Mark a list as incomplete.
    static func markListAsIncomplete(_ index: Int) {
        
        // Read the list from cache.
        let list = CacheController.readListFromCache(index)
        
        // Mark the list as incomplete.
        list.isCompleted = false
        
        // Update the cache.
        CacheController.writeListToCache(list, index: index)
    }
    
    
    // MARK: - Item Selection
    
    // Check if a certain item at a given listIndex and itemIndex is completed or not.
    static func isCompletedItem(_ listIndex: Int, itemIndex: Int) -> Bool {
        
        // Read the list from cache.
        let list = CacheController.readListFromCache(listIndex)
        
        // Check for the `isCompleted` property for the item at the given `itemIndex`.
        if let item = list.items[itemIndex] as Item? {
            return item.isCompleted
        }
        return false
    }
    
    // Mark a certain item at a given listIndex and itemIndex as complete.
    static func markItemAsComplete(_ listIndex: Int, itemIndex: Int) {
        
        // Read the list from cache.
        let list = CacheController.readListFromCache(listIndex)
        
        // Get the item at `itemIndex` within the items array and mark the item as complete.
        let item = list.items[itemIndex] as Item!
        item?.isCompleted = true
        
        // Save the item back into the items array.
        list.items[itemIndex] = item!
        
        // Update the cache.
        CacheController.writeListToCache(list, index: listIndex)
    }
    
    // Mark a certain item at a given listIndex and itemIndex as incomplete.
    static func markItemAsIncomplete(_ listIndex: Int, itemIndex: Int) {
        
        // Read the list from cache.
        let list = CacheController.readListFromCache(listIndex)
        
        // Get the item at `itemIndex` within the items array and mark the item as complete.
        let item = list.items[itemIndex] as Item!
        item?.isCompleted = false
        
        // Save the item back into the items array.
        list.items[itemIndex] = item!
        
        // Update the cache.
        CacheController.writeListToCache(list, index: listIndex)
    }
}
