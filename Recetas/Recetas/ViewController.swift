//
//  ViewController.swift
//  Recetas
//
//  Created by Ivan Da Palma on 17/11/16.
//  Copyright © 2016 Ivan Da Palma. All rights reserved.
//

import UIKit

/* 
 Hemos eliminado la vista en el Main Storyboard e insertado un Table View Controller
 En ViewController.swift hemos cambiado la herencia UIVIewController por UITableViewController
 Hemos marcado la opción "Is Initial View Controller" en el Main Storyboard
 Hemos puesto en Custom Class la clase ViewController en el Main Storyboard
 Si dejara la vista inicial habría que añadir las clases UITableViewDataSource y UITableViewDelegate 
 (además del UIVIewController que ya estaba)
*/

class ViewController: UITableViewController {

    var recipes : [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
       
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
    
    // Ocultar la barra de navegación al hacer scroll
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }
    
    
    /*
    // Ocultar barra. Opción 2
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    */
    
    
    // MARK: - UITableViewDataSource
    
    // Numero de secciones
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // Numero de filas por sección
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipes.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let recipe = recipes[indexPath.row]
        // indexPath.row devuelve la fila en la que estamos (se llama por cada fila que tenga la tabla)
        // así podemos devolver la receta en la fila en la que estamos
        // Hay que darle un identificador a la celda que viene por defecto con UITableViewController
    
        let cellID =  "RecipeCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RecipeCell
        // dequeReusabelCell se usa para poder ver las celdas de debajo e internamente
        // se borra momentaneamente la fila de arriba para que se pueda ver la de abajo al arrastrar
        // as! RecipeCell es para decirle que es una celda customizada y que la clase que que la lleva es RecipeCelle que la hemos creado
        
        
        cell.imageCell.image = recipe.image
        cell.nameLabel.text = recipe.name
        cell.timeLabel.text = "\(recipe.time!) min"
        cell.ingredientsLabel.text = "Ingredientes: \(recipe.ingredients.count)"
        
        
        // Marcar el check de una celda si es favorita. Para evitar errores hay que poner el else
        /*
        if recipe.isFavourite {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        */
        
        /* 
        // Se ha añadido desde el storyboard -> User Defined Runtime Attributes (forma 2)
        // y marcado Clip to Bounds
        // Layer trata la parte visual de las imagenes
        cell.imageCell.layer.cornerRadius =  42.0 // Radio de la esquina
        cell.imageCell.clipsToBounds = true // elimina lo que esté fuera del círculo del radio
         */
        return cell
        
    }
    
    // Swipe delete button. Borrar deslizando fila
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.recipes.remove(at: indexPath.row)
        }
        
        //self.tableView.reloadData() // Actualizar la tabla completa (no eficiente para muchos datos)
        self.tableView.deleteRows(at: [indexPath], with: .fade) // Solo borra la fila
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // Compartir (sustituye el botón de borrar. Hay que añadirle aparte -> abajo)
        let shareAction = UITableViewRowAction(style: .normal, title: "\u{2605}\n Compartir") { (action, indexPath) in
            
            // Compartir en redes sociales y iCloud
            
            let shareDefaultText = "Estoy mirando la receta de \(self.recipes[indexPath.row].name!) en la app de Recetas de Iván Da Palma" // Texto que pone al compartir
            
            let activityController = UIActivityViewController(activityItems: [shareDefaultText,self.recipes[indexPath.row].image], applicationActivities: nil)
            
            self.present(activityController, animated: true, completion: nil)
        }
        shareAction.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        
        // Borrar (logo es un Unicode Icon)
        let deleteAction = UITableViewRowAction(style: .destructive, title: "\u{232B}\n Borrar") { (action, indexPath) in
            
            // Acción de borrar
            self.recipes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        return [deleteAction, shareAction]
    }
    
    
    // MARK: UITableViewDelegate
    
    // Al clickear en una fila
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    /*
        let recipe = self.recipes[indexPath.row]
        
        var favouriteActionTitle = "Favorito"
        var favouriteActionStyle = UIAlertActionStyle.default
        if recipe.isFavourite {
            favouriteActionTitle = "Quitar favorito"
            favouriteActionStyle = UIAlertActionStyle.destructive
        }

        
        let alertController = UIAlertController(title: recipe.name, message: nil, preferredStyle: .actionSheet)
        
        // .actionSheet muestra alerta abajo
        // .alert muestra la alerta en el centro
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        
        let favouriteAction = UIAlertAction(title: favouriteActionTitle, style: favouriteActionStyle) { (action) in
            
            let recipe = self.recipes[indexPath.row]
            recipe.isFavourite = !recipe.isFavourite
            self.tableView.reloadData() // Actualizar datos de la tabla
        }
        
        alertController.addAction(favouriteAction)
        
        self.present(alertController, animated: true, completion: nil)
    */
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showRecipeDetail"{ // Segue al que va dirigido
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let selectedRecipe = self.recipes[indexPath.row] // Selecciona la receta
                let destintationViewController = segue.destination as! DetailViewController // ViewController al que va dirigido
                destintationViewController.recipe = selectedRecipe
            }
            
        }
        
    }

}

