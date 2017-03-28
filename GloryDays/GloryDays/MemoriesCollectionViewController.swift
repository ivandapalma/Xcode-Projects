//
//  MemoriesCollectionViewController.swift
//  GloryDays
//
//  Created by Ivan Da Palma on 5/3/17.
//  Copyright © 2017 Ivan Da Palma. All rights reserved.
//


// Clase para gestionar el ViewController de la colección

import UIKit
import AVFoundation
import Photos
import Speech
import CoreSpotlight // Para el buscador
import MobileCoreServices // Para el buscador

private let reuseIdentifier = "cell"

// añadir UIImagePickerControllerDelegate y UINavigationControllerDelegate para elegir imágenes
class MemoriesCollectionViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVAudioRecorderDelegate, UISearchBarDelegate  {

    
    var memories : [URL] = []
    var filteredMemories : [URL] = []
    
    var currentMemory : URL!
    var audioPlayer : AVAudioPlayer?
    var audioRecorder : AVAudioRecorder?
    var recordingURL : URL!
    
    var searchQuery : CSSearchQuery?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.recordingURL =  try? getDocumentsDirectory().appendingPathComponent("memory-recording.m4a")
        
        self.loadMemories()
        
        // Añade un boton tipo add ("+") a la barra de navegación
        // target es quién lo gestiona (en este caso nosotros)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addImagePressed))
        
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

        // Registra la clase de la celda
        //self.collectionView!.register(MemoryCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool){
        
        super.viewDidAppear(animated) // La super clase haga lo que tenga que hacer
        self.checkForGrantedPermissions()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func checkForGrantedPermissions(){
        let photoAuth : Bool = PHPhotoLibrary.authorizationStatus() == .authorized
        let recordAuth : Bool = AVAudioSession.sharedInstance().recordPermission() == .granted
        let transciptionAuth : Bool =  SFSpeechRecognizer.authorizationStatus() == .authorized
        
        let authorized = photoAuth && recordAuth && transciptionAuth
        
        // Si no estamos autorizados, mostramos el ViewController ShowTerms (el de autorizaciones)
        if !authorized {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ShowTerms") {
                navigationController?.present(vc, animated: true, completion: nil)
                // completion: nil)  no hace falta
            }
        }
        
    }
    
    
    
    func loadMemories() {
        
        // Primero eliminamos los recuerdos existentes
        self.memories.removeAll()
        
        // Guard es como un bloque try-catch
        // intentamos cargar los archivos del la URL de getDocumentsDirectory
        guard let files = try? FileManager.default.contentsOfDirectory(at: getDocumentsDirectory(), includingPropertiesForKeys: nil, options: [])
        
        else
        {
            return // Retorno vacío por si peta
        }
        
        
        // Recorremos los archivos
        for file in files
        {
            
            guard let fileName = try? file.lastPathComponent else { continue }
            
            if fileName.hasSuffix(".thumb"){ // Si es una miniatura
                let noExtension = fileName.replacingOccurrences(of: ".thumb", with: "")
                
                if let memoryPath = try? getDocumentsDirectory().appendingPathComponent(noExtension)
                {
                    memories.append(memoryPath)
                }
            }
        }
        
        filteredMemories = memories
        
        // Las secciones empiezan en la 0, en la 1 tenemos la cajita de búsqueda
        collectionView?.reloadSections(IndexSet(integer: 1))
    }
    
    
    // Devuelve la URL del directorio donde se van a guardar los archivos
    func getDocumentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
     
        return documentsDirectory
    }
    
    
    func addImagePressed() {
        
        let vc = UIImagePickerController()
        vc.modalPresentationStyle = .formSheet // Mostrar view controller
        vc.delegate = self
        // Nuestra propia clase es la que va a gestionar la selección
        // o cancelación de selección de imágenes
        
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    
    // Función que selecciona una imagen
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let theImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.addNewMemory(image: theImage)
            self.loadMemories() // Después de seleccionar la foto hay que cargar la vista
            dismiss(animated: true) // Cuando elige una imagen, se sale
            
            
        }
    }
    
    // Guarda el fichero de la imagen y su miniatura (thumbail)
    func addNewMemory(image: UIImage){
        
        // Hay que generar un identificador para cada imagen
        // Se podría usar tambien NSUUID, pero vamos a usar la fecha de añadido
        
        let memoryName = "memory-\(Date().timeIntervalSince1970)"
        let imageName = "\(memoryName).jpg"
        let thumbName = "\(memoryName).thumb"
        
        do {
            // En la carpeta principal donde están todos los recuros
            // de nuestra aplicación crea una carpeta para la imagen en jpg
            let imagePath = try getDocumentsDirectory().appendingPathComponent(imageName)
            
            // Las imágenes no se pueden guardar directamente. Hay q transformarlas a bytes
            // 80 es la compresión (100 es casi sin compirmir)
            // atomicWrite es para que lo escriba todo del tirón. No a trocitos
            if let jpegData = UIImageJPEGRepresentation(image, 80) {
                try jpegData.write(to: imagePath, options: [.atomicWrite])
            }
            
            // Crear las miniaturas -> Redimensión (escalado)
            // Igual que antes, solo que hemos creado primero la miniatura
            if let thumbail = resizeImage(image: image, to: 200)
            {
                let thumbPath = try getDocumentsDirectory().appendingPathComponent(thumbName)
                if let jpegData = UIImageJPEGRepresentation(thumbail, 80) {
                    try jpegData.write(to: thumbPath, options: [.atomicWrite])
                }
                
            }
            
            
        } catch {
            print("Ha fallado la escritura en disco")
        }
        
        
    }
    
    // Redimensión
    func resizeImage(image: UIImage, to width: CGFloat) -> UIImage?{
    
        // Calculamos el factor de escalado
        let scaleFactor = width / image.size.width
        
        // Conservando la proporción reduzco la altura (evita deformaciones)
        let height = image.size.height * scaleFactor
        
        // Redimensionamos la imagen con los tamaños
        // El false indica que el fondo va a ser opaco, no transparente
        // 0: Estamos creando una imagen con la resolucion del dispositivo que estamos utilizando
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        
        // Primero retocamos la imagen redibujándola en un rectángulo de anchura "width" y altura "height"
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        
        // Extraemos de ese contexto la imagen actual para generar una nueva imagen
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        //Hemos terminado la edición
        UIGraphicsEndImageContext()
    
        return newImage
    }
    
    
    // Sabemos que la URL es válida, por eso forzamos todas con el try con !
    func imageURL(for memory: URL) -> URL {
        
        return try! memory.appendingPathExtension("jpg")
    }
    
    func thumbailURL(for memory: URL) -> URL {
        
        return try! memory.appendingPathExtension("thumb")
    }
    
    func audioURL(for memory: URL) -> URL {
        
        return try! memory.appendingPathExtension("m4a")
    }
    
    func transcriptionURL(for memory: URL) -> URL {
        
        return try! memory.appendingPathExtension("txt")
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        // Numero de secciones: Header (buscador) y CollectionView
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        // Números de elementos por cada sección
        if section == 0 {
            return 0
        }
        else {
            return self.filteredMemories.count
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemoryCell
        // Hay que añadir as! MemoryCell para hacerle el casting
    
        // Configure the cell
        let memory = self.filteredMemories[indexPath.row]
        let memoryName = self.thumbailURL(for: memory).path
        let image = UIImage(contentsOfFile: memoryName)
        cell.imageView.image = image
        
        // añadimos pulsación larga
        if cell.gestureRecognizers == nil {
            let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.memoryLongPressed))
        
            recognizer.minimumPressDuration = 0.3
            cell.addGestureRecognizer(recognizer)
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 4
            cell.layer.cornerRadius = 10
            
        }
        
        return cell
    }

    
    func memoryLongPressed(sender: UILongPressGestureRecognizer){
        
        // Si está pulsado para empezar a grabar obtenemos qué celda se ha pulsado
        if sender.state == .began {
        
            let cell = sender.view as! MemoryCell
            if let index = collectionView?.indexPath(for: cell) {
                self.currentMemory = self.filteredMemories[index.row]
                self.startRecordingMemory()
            }
            
        }
        
        // Deja de pulsar -> Se acaba la grabación
        if sender.state == .ended {
            self.finishRecordingMemory(success: true)
        }
    }
    
    
    func startRecordingMemory(){
        
        audioPlayer?.stop() // Por si está ejecutando un audio
        collectionView?.backgroundColor = UIColor(red: 0.6, green: 0.0, blue: 0.0, alpha: 1.0)
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
            try recordingSession.setActive(true) // Preparado para grabar
            let recordingSettings = [ AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                                      AVSampleRateKey : 44100,
                                      AVNumberOfChannelsKey : 2,
                                      AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            
            ]
            
            audioRecorder = try AVAudioRecorder(url: recordingURL, settings: recordingSettings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            
        } catch let error {
            print(error)
            self.finishRecordingMemory(success: false)
        }
        
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecordingMemory(success: false)
        }
    }
    
    func finishRecordingMemory(success: Bool){
        
        // Volvemos al color de antes
        collectionView?.backgroundColor = UIColor(red: 97.0/255.0, green: 86.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        
        // Parar el audio recorder
        audioRecorder?.stop()
        
        if success {
           
            do {
                
                let memoryAudioURL = try self.currentMemory.appendingPathExtension("m4a")
                let fileManager = FileManager.default
                
                if fileManager.fileExists(atPath: memoryAudioURL.path) {
                    try fileManager.removeItem(at: memoryAudioURL)
                    
                }
               
                try fileManager.moveItem(at: recordingURL, to: memoryAudioURL)
                self.transcribeAudioToText(memory: self.currentMemory)
                
            }catch let error {
                print("Ha habido un error: \(error)")
            }
        }
        
    }
    
    
    func transcribeAudioToText(memory: URL){
        
        let audio = audioURL(for: memory)
        let transcription = transcriptionURL(for: memory)
        
        let recognizer = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: audio)
        
        recognizer?.recognitionTask(with: request, resultHandler: { [unowned self] (result, error) in
            
            // [unowned self] es para gestionar mejor los posibles errores
            
            guard let result = result else {
                print("Ha habido un error: \(error)")
                return
            }
            
            if result.isFinal {
                
                let text = result.bestTranscription.formattedString // La mejor transcripción
                
                do {
                    try text.write(to: transcription, atomically: true, encoding: String.Encoding.utf8)
                    self.indexMemory(memory: memory, text: text) // Indexar texto al sportlight
                
                } catch {
                    print("ha habido un error al guardar la transcripción")
                }
                
            }
            
        })
        
    }
    
    // Indexar texto al spotlight
    func indexMemory(memory: URL, text: String){
        
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        attributeSet.title = "Recuerdo de Glory Days"
        attributeSet.contentDescription = text
        attributeSet.thumbnailURL = thumbailURL(for: memory) // Muestra la foto en Spotlight
        
        let item = CSSearchableItem(uniqueIdentifier: memory.path, domainIdentifier: "com.ivandapalma", attributeSet: attributeSet)
        
        // Fecha de expiracion
        item.expirationDate = Date.distantFuture
        
        // indexar texto al spotlight
        CSSearchableIndex.default().indexSearchableItems([item]) { (error) in
            
            if let error = error {
                
                print("Ha habido un problema al indexar: \(error)")
            }
            else {
                print("H emos podido indexar correctamente el texto: \(text)")
            }
        }
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 0 {
            return CGSize(width: 0, height: 50)
        }
        else {
            return CGSize.zero
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let memory = self.filteredMemories[indexPath.row]
        let fileManager = FileManager.default
        do {
            
            let audioName = audioURL(for: memory)
            let transcriptionName = transcriptionURL(for: memory)
            
            if fileManager.fileExists(atPath: audioName.path) {
            
                self.audioPlayer = try AVAudioPlayer(contentsOf: audioName)
                self.audioPlayer?.play()
            }
            
            if fileManager.fileExists(atPath: transcriptionName.path) {
                
                let contents = try String(contentsOf: transcriptionName)
                print(contents)
            }
            
            
        } catch {
            print("Error al cargar el audio para reproducir")
        }
        
    }
    
    func filterMemories(text: String){
        
        // Por si la búsqueda es vacía al borrar el texto en la caja de busqueda muestre todos
        guard text.characters.count > 0 else {
            self.filteredMemories = memories
            UIView.performWithoutAnimation {
                collectionView?.reloadSections(IndexSet(integer: 1))
            }
            return
        }
        
        
        
        var allTheItems : [CSSearchableItem] = []
        
        searchQuery?.cancel() // Si hay consulta ejecutándose, la paramos
        
        // Busca el texto en "contentDescription" con algo delante (*), algo detrás (*) y case insensitive (c)
        let queryString = "contentDescription == \"*\(text)*\"c"
        
        self.searchQuery = CSSearchQuery(queryString: queryString, attributes: nil)
        
        // Cada vez que encontremos un objeto que case con la consulta lo añadimos al array "allTheItems"
        self.searchQuery?.foundItemsHandler = { items in
        
            allTheItems.append(contentsOf: items)
        }
        
        // Si no ha habido ningún error, en el hilo de ejecución principal, los filtramos
        self.searchQuery?.completionHandler = { error in
            
            DispatchQueue.main.async { [unowned self] in
                self.activateFilter(matches: allTheItems)
            }
        
        }
        
        self.searchQuery?.start() // Ejecutar consulta
    
    }
    
    // Filtrar imágenes
    func activateFilter(matches: [CSSearchableItem]) {
        
        self.filteredMemories = matches.map{ (item) in
            
            let uniqueID = item.uniqueIdentifier
            let url = URL(fileURLWithPath: uniqueID)
            return url
        }
        
        UIView.performWithoutAnimation {
            collectionView?.reloadSections(IndexSet(integer: 1))
        }
    }
    
    
    // Se busca cada vez que cambia un carácter en la caja de texto
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filterMemories(text: searchText)
    
    }
    
    // Se ejecuta cuando se busca el botón de buscar en el teclado
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // Ocultar teclado
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
