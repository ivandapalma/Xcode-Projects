//
//  ViewController.swift
//  Reconocimiento de Voz
//
//  Created by Ivan Da Palma on 2/3/17.
//  Copyright © 2017 Ivan Da Palma. All rights reserved.
//

import UIKit
import Speech
// Habría q importar AVFoundation para el micro, pero no hace falta. Desde iOS 10 viene incluido en Xcode

class ViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet var textView: UITextView!
    var audioRecordingSession : AVAudioSession!
    let audioFileName : String = "audio-recordered.m4a"
    var audioRecorder : AVAudioRecorder!
    var newTimeInterval : Double = 0.0
    
    @IBOutlet var tfTime: UITextField!
    @IBOutlet var timeLeft: UILabel!
    
    @IBAction func btnStartRecording(_ sender: UIButton) {
        
        recordingAudioSetup()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //recordingAudioSetup()
        timeLeft.text = ""
        tfTime.text = "\(0)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func recognizeSpeech()
    {
        // Bloque de completación. Lo de después del "in" se ejecuta si el usuario da autorización
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                
                let recognizer = SFSpeechRecognizer()
                let request = SFSpeechURLRecognitionRequest(url: self.directoryURL()!)
                    
                recognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
                        
                    if let error = error {
                        print("Algo ha ido mal: \(error.localizedDescription)")
                    } else {
                        self.textView.text = String(describing: result?.bestTranscription.formattedString)
                    }
                })
                    
                
                
            } else {
                print("Sin acceso a Speech Recognizer")
            }
            
        }
    
    }
    
    // Uso del microfono
    func recordingAudioSetup(){
        
        // Por defecto 10 segundos
        if (Int(tfTime.text!)! <= 0) || (tfTime.text! == "")
        {
            tfTime.text = "\(10)"
        }
        
        if (Int(tfTime.text!)! > 15){
            
            tfTime.text = "\(15)"
        }
        
        
        newTimeInterval = Double(tfTime.text!)!
        
        audioRecordingSession = AVAudioSession.sharedInstance()
        
        do
        {
            try audioRecordingSession.setCategory(AVAudioSessionCategoryRecord)
            try audioRecordingSession.setActive(true) // listos para empezar a grabar
            
            // Pedir permiso para acceder al micro
            audioRecordingSession.requestRecordPermission({[unowned self] (allowed:Bool) in
             
                if allowed  // Hay que empezar a grabar ya que tenemos permiso
                {
                    // Grabar el audio
                    self.startRecording()
                    
                }
                else
                {
                    print("Se necesitan permisos para acceder al micro")
                }
                
            })
        }
        catch
        {
            print("Ha habido un error en el audio recorder")
        }
        
    }

    func directoryURL() -> URL? { // Devuelve una URL opcionalmente (?)
        
        // Gestor de archivos por defecto
        let fileManager = FileManager.default
        
        // Buscamos la estructura donde guardar el archivo. documentDirectory es el directorio de iOS
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        // Nos quedamos con la primera
        let documentsDirectory = urls[0] as URL
        
        do{
            return try documentsDirectory.appendingPathComponent(audioFileName)
        } catch{
            print("No hemos podido crear la estructura de carpetas para guardar el audio")
        }
        return nil
        
    }
    
    // Función para empezar a grabar
    func startRecording() {
        
        let settings = [AVFormatIDKey : Int(kAudioFormatMPEG4AAC),
                        AVSampleRateKey : 12000.0,
                        AVNumberOfChannelsKey : 1 as NSNumber,
                        AVEncoderAudioQualityKey : AVAudioQuality.high.rawValue] as [String : Any] // rawValue convierte en int
        
        do {
            audioRecorder = try AVAudioRecorder(url: directoryURL()!, settings: settings)
            audioRecorder.delegate = self // Obligatorio
            audioRecorder.record()
            
            
            if newTimeInterval >= 0.0 {
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.newTime), userInfo: nil, repeats: true)
            }
            else {
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.newTime), userInfo: nil, repeats: false)
            }
            
            // Para finalizar la grabación
            Timer.scheduledTimer(timeInterval: Double(tfTime.text!)!, target: self, selector: #selector(self.stopRecording), userInfo: nil, repeats: false)
            
        } catch {
            print("No se ha podido grabar el audio correctamente")
        }
        
        
    }
    
    // Parar la grabación
     func stopRecording() {
        
        newTime()
        audioRecorder.stop()
        audioRecorder = nil
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.recognizeSpeech), userInfo: nil, repeats: false)
        
        timeLeft.text = ""

    
    }
    
    func newTime() {
        if newTimeInterval >= 0.0 {
            newTimeInterval = newTimeInterval - 1.0
            timeLeft.text = "Tiempo restante: \(Int(newTimeInterval))"
        }
    }

    // Ocultar teclado al pulsar fuera -> Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}

