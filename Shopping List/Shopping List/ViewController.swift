//
//  ViewController.swift
//  Shopping List
//
//  Created by Ivan Da Palma on 10/10/15.
//  Copyright © 2015 Ivan Da Palma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var items = [String]()
    let defaults = UserDefaults.standard
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var tableView: UITableView!
    
    @IBAction func deleteItems(_ sender: UIButton) {
        items.removeAll()
        defaults.set(items, forKey: "cesta")
        defaults.synchronize()
        tableView.reloadData()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var objetos = defaults.stringArray(forKey: "cesta")
        if(objetos != nil){
            for index in 1...objetos!.count{ // 0..<objetos!.count+=1
                items.append(objetos![index-1])
            }
            tableView.reloadData()
        }
    }
    
    @IBAction func addButtom(_ sender: UIButton) {
        
        let newItem = textField.text
        if newItem != "" {
            items.append(newItem!)
        }
        textField.resignFirstResponder()
        textField.text = ""
        tableView.reloadData()
        defaults.set(items, forKey: "cesta")
        defaults.synchronize()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        cell.textLabel!.text = items[(indexPath as NSIndexPath).row]
        cell.textLabel!.textColor = UIColor.black
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedRow:UITableViewCell = tableView.cellForRow(at: indexPath)!
        
        if selectedRow.accessoryType == UITableViewCellAccessoryType.none{
            selectedRow.accessoryType = UITableViewCellAccessoryType.checkmark
            selectedRow.tintColor = UIColor.green
            
        }
        else{
            selectedRow.accessoryType = UITableViewCellAccessoryType.none
        }
        
    }
       
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let deletedRow:UITableViewCell = tableView.cellForRow(at: indexPath)!
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            items.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            deletedRow.accessoryType = UITableViewCellAccessoryType.none            
            defaults.set(items, forKey: "cesta")
        }
    }
       
    
}

