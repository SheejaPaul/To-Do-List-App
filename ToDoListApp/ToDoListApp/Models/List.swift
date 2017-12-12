//
//  List.swift
//  ToDoListApp
//
//  Created by Admin on 9/27/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import UIKit

class List: NSObject, NSCoding {
    var name: String
    var items: [Item]
    var isCompleted: Bool = false
    
    // MARK: - Object Life-cycle
    
    init(name providedName: String, items providedItems: [Item]) {
        name = providedName
        items = providedItems
        super.init()
    }
    
    // MARK: - NSCoding
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.items = (aDecoder.decodeObject(forKey: "items") as? Array)!
        self.isCompleted = aDecoder.decodeBool(forKey: "isCompleted") as Bool
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(items, forKey: "items")
        aCoder.encode(isCompleted, forKey: "isCompleted")
    }
}
