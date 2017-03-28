//
//  ViewController.swift
//  ConversorDivisas
//
//  Created by Ivan Da Palma on 22/10/16.
//  Copyright © 2016 Ivan Da Palma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var segmented: UISegmentedControl!
    @IBOutlet var segmented2: UISegmentedControl!
    @IBOutlet var resultado: UILabel!
    let dollarUnit : Double = 1.08852
    let poundUnit : Double = 0.889899
    let dollarPoundUnit : Double = 0.817528
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resultado.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if  textField.text != "" &&
            Double(textField.text!)?.isNaN == false &&
            segmented.selectedSegmentIndex != segmented2.selectedSegmentIndex
        {
            resultado.text = convert(fromUnit: segmented.selectedSegmentIndex,
                                     toUnit: segmented2.selectedSegmentIndex)
        }
    }
    
    func convert(fromUnit: Int, toUnit: Int) -> String{
    
        var res = "";
        let textFieldDouble : Double = Double(textField.text!)!
        var conv : Double = 0
        var convStr = ""

        // € a $
        if fromUnit==0 && toUnit==1 {
            
            conv = textFieldDouble * dollarUnit;
            convStr = String(format: "%.3f", conv)

        }
        
        // € a £
        if fromUnit==0 && toUnit==2 {
            
            conv = textFieldDouble * poundUnit
            convStr = String(format: "%.3f", conv)
            
        }
        
        // $ a €
        if fromUnit==1 && toUnit==0 {
            
            conv = textFieldDouble / dollarUnit
            convStr = String(format: "%.3f", conv)
            
        }
        
        // $ a £
        if fromUnit==1 && toUnit==2 {
            
            conv = textFieldDouble * dollarPoundUnit;
            convStr = String(format: "%.3f", conv)
            
            
        }
        
        // £ a €
        if fromUnit==2 && toUnit==0 {
            
            conv = textFieldDouble / poundUnit
            convStr = String(format: "%.3f", conv)
            
        }
        
        // £ a $
        if fromUnit==2 && toUnit==1 {
            
            conv = textFieldDouble / dollarPoundUnit
            convStr = String(format: "%.3f", conv)
            
        }
        
        
        let unidad1 = setConvText(index: fromUnit)
        let unidad2 = setConvText(index: toUnit)
        
        res = "\(textField.text!) \(unidad1) = \(convStr) \(unidad2)"
        //resultado.text = "\() km = \() millas"
        return res

    }
    
    
    func setConvText(index: Int) -> String{
        
        if index == 0 {
            return " € "
        }
        else if index==1{
            return " $ "
        }
        else {
            return " £ "
        }
    }
    
    
    // Oculta la barra de arriba (hora, operador de telefonía, etc...)
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}

