//
//  ItemTableViewCell.swift
//  ToDoListApp
//
//  Created by Admin on 9/27/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var optionButton: UIButton!
    @IBOutlet weak var itemNameLabel: UILabel!
    var listIndex: Int?
    var itemIndex: Int?
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - Event handlers

    @IBAction func optionButtonDidTap(_ sender: UIButton) {
        
        // Check if the item is completed and mark it as the opposite of that.
        if SelectionController.isCompletedItem(listIndex!, itemIndex: itemIndex!) {
            SelectionController.markItemAsIncomplete(listIndex!, itemIndex: itemIndex!)
        } else {
            SelectionController.markItemAsComplete(listIndex!, itemIndex: itemIndex!)
        }
        
        // Also, set the image to reflect this.
        let imageName = SelectionController.isCompletedItem(listIndex!, itemIndex: itemIndex!) ? "radio-button-on" : "radio-button-off"
        self.optionButton.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
    }
}
