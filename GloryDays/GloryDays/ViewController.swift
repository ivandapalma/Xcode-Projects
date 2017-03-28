//
//  ViewController.swift
//  GloryDays
//
//  Created by Ivan Da Palma on 5/3/17.
//  Copyright © 2017 Ivan Da Palma. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import Speech

class ViewController: UIViewController {

    @IBOutlet var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func askForPermission(_ sender: UIButton) {
        self.askForPhotosPermissions()
    }

    
    func askForPhotosPermissions() {
        
        PHPhotoLibrary.requestAuthorization { [unowned self] (authStatus) in
            DispatchQueue.main.async{ // Manda al hilo de ejecución principal
                if authStatus == .authorized {
                    self.askForRecordPermissions()
                }
                else {
                    self.infoLabel.text = "Se ha denegado el permiso de fotos. Actívelo en Ajustes"
                }
            }
            
        }
    }
    
    func askForRecordPermissions() {
        
        AVAudioSession.sharedInstance().requestRecordPermission { [unowned self] (allowed) in
            DispatchQueue.main.async{ // Manda al hilo de ejecución principal
                if allowed {
                    self.askForTranscriptionPersmissions()
                }
                else {
                    self.infoLabel.text = "Se ha denegado el permiso de grabación de audio. Actívelo en Ajustes"
                }
            }
        }
        
    }
    
    func askForTranscriptionPersmissions() {
        
        SFSpeechRecognizer.requestAuthorization { [unowned self] (authStatus) in
            DispatchQueue.main.async{ // Manda al hilo de ejecución principal
                if authStatus == .authorized {
                    self.authorizationCompleted()
                }
                else {
                    self.infoLabel.text = "Se ha denegado el permiso de transcripción de texto. Actívelo en Ajustes"
                }
            }
        }
        
    }
    
    func authorizationCompleted() {
        
        dismiss(animated: true, completion: nil) // Oculta el ViewController actual( completion nil no hace falta ponerlo)
        
    }
    
}

