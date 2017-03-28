//
//  FullRecipeCell.swift
//  Recetas
//
//  Created by Ivan Da Palma on 17/11/16.
//  Copyright © 2016 Ivan Da Palma. All rights reserved.
//

import UIKit

class FullRecipeCell: UITableViewCell {
    
    
    @IBOutlet var labelCell: UILabel!
    @IBOutlet var imageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
  }
