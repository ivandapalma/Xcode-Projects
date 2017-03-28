//
//  DetailViewController.swift
//  Recetas
//
//  Created by Ivan Da Palma on 22/11/16.
//  Copyright © 2016 Ivan Da Palma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var recipeImageView: UIImageView!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var ratingButton: UIButton!
    
    var recipe : Recipe!
    
    override func viewDidLoad() {
        self.recipeImageView.image = self.recipe.image
        self.tableView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.25)
        
        
        // A partir de la ultima celda desaparece
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        tableView.separatorColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.75)
    
        self.title = recipe.name
        
        // Calcula el tamaño de cada celda para qu se ajuste a su contenido y lo renderiza dinamicamente
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let image = UIImage(named: self.recipe.rating)
        self.ratingButton.setImage(image, for: .normal)
        
    }
    
    // Ocultar barra
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // Si la barra está oculta, la muestra
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func close(segue: UIStoryboardSegue){
    
        if let reviewWC = segue.source as? ReviewViewController {
            
            if let rating = reviewWC.ratingSelected{
                self.recipe.rating = rating
                let image = UIImage(named: self.recipe.rating)
                self.ratingButton.setImage(image, for: .normal)
            }
        }
        
    }
    
    
}
    
    extension DetailViewController : UITableViewDataSource{
    
        func numberOfSections(in tableView: UITableView) -> Int {
            return 3
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            switch section
            {
                case 0:
                        return 2
                case 1:
                        return self.recipe.ingredients.count
                case 2:
                        return self.recipe.steps.count
                default:
                    return 0
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRecipeCell", for: indexPath) as! RecipeDetailViewCell
            
            cell.backgroundColor = UIColor.clear
            
            switch indexPath.section
            {
                
                case 0: // Nombre, Tiempo y Favorito
                    
                    switch indexPath.row {
                        
                        case 0:
                            cell.keyLabel.text = "Nombre: "
                            cell.valueLabel.text = self.recipe.name
                        case 1:
                            cell.keyLabel.text = "Tiempo: "
                            cell.valueLabel.text = "\(self.recipe.time!) min"
                        /*
                         case 2:
                            cell.keyLabel.text = "Favorito: "
                            if self.recipe.isFavourite
                            {
                                cell.valueLabel.text = "Sí"
                            }
                            else
                            {
                                cell.valueLabel.text = "No"
                            }
                        */
                        
                        default: break
                    }
                
                case 1: // Ingredientes
                
                    if indexPath.row == 0
                    {
                        cell.keyLabel.text = "Ingredientes: "
                    }
                    else
                    {
                        cell.keyLabel.text = ""
                    }
                
                    cell.valueLabel.text = self.recipe.ingredients[indexPath.row]
                
                case 2: // Pasos
                    
                    if indexPath.row == 0
                    {
                        cell.keyLabel.text = "Pasos: "
                    }
                    else
                    {
                        cell.keyLabel.text = ""
                    }
                    
                    cell.valueLabel.text = self.recipe.steps[indexPath.row]
                    
                default: break
            
            }
            
            return cell
            
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            
            var title = ""
            
            switch section {
                
                case 1:
                    title = "Ingredientes"
                case 2:
                    title = "Pasos"
                default:
                    break
            }
            return title
        }
        
        
    }

    extension DetailViewController : UITableViewDelegate{
        
        
    }

