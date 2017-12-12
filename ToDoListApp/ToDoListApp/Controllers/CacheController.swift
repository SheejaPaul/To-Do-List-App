//
//  CacheController.swift
//  ToDoListApp
//
//  Created by Prabhu Bose on 9/28/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import UIKit

// Class to implement the logic for reading/ writing data to the cache at the lists or a certain list level.
class CacheController: NSObject {
    
    // MARK: - Read operations
    
    // Read all lists from the cache.
    static func readListsFromCache() -> [List] {
        var lists = [List]()
        
        // Check if the archived data exists in user defaults and unarchive it into the actual lists array.
        if let data = UserDefaults.standard.data(forKey: "ToDoListApp.ListArray"),
            let newLists = NSKeyedUnarchiver.unarchiveObject(with: data) as? [List] {
            lists = newLists
        }
        return lists
    }
    
    // Read a specific list from the cache.
    static func readListFromCache(_ index: Int) -> List {
        
        // Read the lists from cache and return the specific list at the given index.
        let lists = readListsFromCache()
        return lists[index] as List
    }
    
    // MARK: - Write operations
    
    // Write all lists to the cache.
    static func writeListsToCache(_ lists: [List]) {
        
        // Archive the lists into data and save it to user defauls.
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: lists)
        UserDefaults.standard.set(encodedData, forKey: "ToDoListApp.ListArray")
    }
    
    // Write a specific list at a given index to the cache.
    static func writeListToCache(_ list: List, index: Int) {
        
        // Read all lists from the cache.
        var lists = readListsFromCache()
        
        // Update the list at index with the given `list`.
        lists[index] = list
        
        // Save the lists to the cache.
        self.writeListsToCache(lists)
    }
}
