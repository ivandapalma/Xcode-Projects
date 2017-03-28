//
//  Recipe.swift
//  Recetas
//
//  Created by Ivan Da Palma on 17/11/16.
//  Copyright © 2016 Ivan Da Palma. All rights reserved.
//

import Foundation
import UIKit

class Recipe: NSObject { // Ponemos NSObject para indicar que es un objeto cualquiera. No hereda de nadie
    
    var name : String!
    var image : UIImage!
    var time : Int!
    var ingredients : [String]!
    var steps : [String]!
    //var isFavourite : Bool = false
    
    var rating : String = "rating"
    
    init(name: String, image: UIImage, time: Int, ingredients : [String], steps: [String]){
        self.name = name
        self.image = image
        self.time = time
        self.ingredients = ingredients
        self.steps = steps
    }
}
