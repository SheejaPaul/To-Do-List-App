//
//  ListTableViewCell.swift
//  ToDoListApp
//
//  Created by Admin on 9/27/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var optionButton: UIButton!
    var index: Int?
    
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
    
    @IBAction func optionButtonTapped(_ sender: UIButton) {
        
        // Check if the list is completed and mark it as the opposite of that.
        if SelectionController.isCompletedList(self.index!) {
            SelectionController.markListAsIncomplete(self.index!)
        } else {
            SelectionController.markListAsComplete(self.index!)
        }
        
        // Also, set the image to reflect this.
        let imageName = SelectionController.isCompletedList(self.index!) ? "radio-button-on" : "radio-button-off"
        self.optionButton.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
    }
}
