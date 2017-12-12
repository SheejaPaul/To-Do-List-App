//
//  Item.swift
//  ToDoListApp
//
//  Created by Admin on 9/27/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    let title: String
    var detail: String?
    var isCompleted: Bool = false
    
    // MARK: - Object Life-cycle
    
    init(title providedTitle: String, detail providedDetail: String) {
        self.title = providedTitle
        self.detail = providedDetail
        super.init()
    }
    
    // MARK: - NSCoding
    
    required init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.detail = aDecoder.decodeObject(forKey: "detail") as? String
        self.isCompleted = aDecoder.decodeBool(forKey: "isCompleted") as Bool
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(detail, forKey: "detail")
        aCoder.encode(isCompleted, forKey: "isCompleted")
    }
}
