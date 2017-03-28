//
//  ReviewViewController.swift
//  Recetas
//
//  Created by Ivan Da Palma on 27/2/17.
//  Copyright © 2017 Ivan Da Palma. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var ratingStackView: UIStackView!
    
    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var thirdButton: UIButton!
    
    var ratingSelected : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        
        let scale =  CGAffineTransform(scaleX: 0.0, y: 0.0)
        let translation =  CGAffineTransform(translationX: 0.0, y: 500.0)
        
        //ratingStackView.transform = scale.concatenating(translation) // Combinar escalado con translación
        
        firstButton.transform = scale.concatenating(translation)
        secondButton.transform = scale.concatenating(translation)
        thirdButton.transform = scale.concatenating(translation)
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Animación 1
        /*
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            
                self.ratingStackView.transform =  CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            }, completion: nil)
        
        */
        
        // Animación 2. Damping: Coeficiente de amortiguación (hay 3 animaciones seguidas con los bloques de completación
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.firstButton.transform =  CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            }, completion: { (success) in
        
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
                    
                    self.secondButton.transform =  CGAffineTransform(scaleX: 1.0, y: 1.0)
                    
                    }, completion: { (success) in
                        
                        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
                            
                            self.thirdButton.transform =  CGAffineTransform(scaleX: 1.0, y: 1.0)
                            
                            }, completion: nil)
                })
        })
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func ratingPressed(_ sender: UIButton) {
    
        switch sender.tag {
            
            case 1: ratingSelected = "dislike"
            case 2: ratingSelected = "good"
            case 3: ratingSelected = "great"
            default: break
        
        }
    
        performSegue(withIdentifier: "unwindToDetailView", sender: sender)
    }
    
    
    
}
