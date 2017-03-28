//
//  SingleViewController.swift
//  Recetas
//
//  Created by Ivan Da Palma on 17/11/16.
//  Copyright © 2016 Ivan Da Palma. All rights reserved.
//

import UIKit

class SingleViewController: UIViewController /* , UITableViewDataSource*/ {

    @IBOutlet var tableView: UITableView!
  
    var recipes : [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        /*
        // Para decirle que la table view que el SingleViewController es su delegado (manda)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        */
        
        var recipe = Recipe(name: "Tortilla de patatas",
                            image: #imageLiteral(resourceName: "omelette"),
                            time: 20,
                            ingredients: ["Patatas", "Huevos", "Cebollas", "Sal"],
                            steps: ["Pelar las patatas y las cebollas",
                                    "Sofreir las patatas y las cebollas cortadas",
                                    "Batir los huevos y echarlos 1 minuto a la sartén con el resto"])
        
        recipes.append(recipe)
        
        recipe = Recipe(name: "Pizza margarita",
                        image: #imageLiteral(resourceName: "pizza"),
                        time: 60,
                        ingredients: ["Harina", "Levadura", "Aceite", "Sal", "Salsa de tomate", "Queso"],
                        steps: ["Hacemos la masa con harina, levadura, aceite y sal",
                                "Dejamos reposar la masa durante 30 minutos",
                                "Extendemos la masa encima de una bandeja y añadimos el resto de ingredientes",
                                "Hornear durante 12 minutos"])
        recipes.append(recipe)
        
        recipe = Recipe(name: "Hamburguesa con queso",
                        image: #imageLiteral(resourceName: "burger"),
                        time: 10,
                        ingredients: ["Pan de hamburguesa", "Lechuga", "Queso", "Carne"],
                        steps: ["Poner al fuego la carne al gusto",
                                "Montar la hamburguesa con los ingredientes en el pan"])
        recipes.append(recipe)
        
        recipe = Recipe(name: "Ensalada César",
                        image: #imageLiteral(resourceName: "salad"),
                        time: 15,
                        ingredients: ["Lechuga", "Queso", "Crutons", "Salsa César", "Pollo"],
                        steps: ["Limpiar todas las verduras y trocearlas",
                                "Cocer el pollo al gusto",
                                "Juntar todos los ingredientes en una ensaladera",
                                "Servir con salsa césar por encima"])
        recipes.append(recipe)
        
        recipe = Recipe(name: "Huevos Revueltos",
                        image: #imageLiteral(resourceName: "HuevosRevueltos"),
                        time: 5,
                        ingredients: ["Huevos", "Jamon York", "Sal"],
                        steps: ["Echamos en una sartén los huevos batidos y el jamón york",
                                "Removemos hasta que estén dorados"])
        recipes.append(recipe)
        
        recipe = Recipe(name: "Tallarines con verduras",
                        image: #imageLiteral(resourceName: "Tallarines"),
                        time: 25,
                        ingredients: ["Tallarines", "Pimientos", "Cebollas", "Salsa de soja"],
                        steps: ["Freimos en una sartén los pimientos y las cebollas en tiras",
                                "Cocemos los tallarines",
                                "Cuando estén cocidos apartamos y lo mezclamos con las verduras",
                                "Echamos salsa de soja encima de los tallarines y removemos"])
        recipes.append(recipe)
        
        recipe = Recipe(name: "Pollo al horno",
                        image: #imageLiteral(resourceName: "polloAlHorno"),
                        time: 60,
                        ingredients: ["Pollo", "Patatas", "Sal"],
                        steps: ["Ponemos aceite y una capa de patatas cortadas en una bandeja",
                                "Añadimos el pollo",
                                "Dejamos hornear 45 minutos y le damos la vuelta al pollo",
                                "Pasados 15 minutos apagamos el horno"])
        recipes.append(recipe)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Ocultar barra. Opción 1
    override var prefersStatusBarHidden: Bool {
        return true
    }

}

extension SingleViewController: UITableViewDataSource {

    // Numero de 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // Numero de filas por sección
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let recipe = recipes[indexPath.row]
        // indexPath.row devuelve la fila en la que estamos (se llama por cada fila que tenga la tabla)
        // así podemos devolver la receta en la fila en la que estamos
        // Hay que darle un identificador a la celda que viene por defecto con UITableViewController
        
        let cellID =  "RecipeCell"
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FullRecipeCell
        // dequeReusabelCell se usa para poder ver las celdas de debajo e internamente
        // se borra momentaneamente la fila de arriba para que se pueda ver la de abajo al arrastrar
        cell.imageCell.image = recipe.image
        cell.labelCell.text = recipe.name
        
        
        return cell
        
    }

}
