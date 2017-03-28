//
//  RecipeCell.swift
//  Recetas
//
//  Created by Ivan Da Palma on 17/11/16.
//  Copyright © 2016 Ivan Da Palma. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {

    
    @IBOutlet var imageCell: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var ingredientsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
