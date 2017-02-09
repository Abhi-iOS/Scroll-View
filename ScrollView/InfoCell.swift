//
//  InfoCellTableViewCell.swift
//  ScrollView
//
//  Created by Appinventiv on 08/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit


//MARK: InfoCell Nib
class InfoCell: UITableViewCell {
    
    // Outlet of the Label in the InfoCell
    @IBOutlet weak var titleLabel: UILabel!
    
    // Outlet of the Text Field in the InfoCell
    @IBOutlet weak var inputTextField: UITextField!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //configure Data to the cell content
    func configureData(_ data: [String:String]){
        titleLabel.text = data["title"]
        inputTextField.text = data["data"]
    }
    
    
      
}
