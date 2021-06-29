//
//  CameraModel.swift
//  CalmPets
//
//  Created by Aarón Cervantes Álvarez on 25/06/21.
//

import SwiftUI
import AVFoundation
import FirebaseStorage

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var isTaken = false
    @Published var alert = false
    
    // Input Camera
    @Published var session = AVCaptureSession()
    
    // Output Photo. Getting Photo
    @Published var output = AVCapturePhotoOutput()
    
    // Camera Preview
    @Published var preview: AVCaptureVideoPreviewLayer!
    
    // Save Photo
    @Published var isSaved = false;
    @Published var imageData = Data(count: 0)
    
    func check() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            // Mark: Setting up Session
            setup()
            return
        case .notDetermined:
            // Mark: Asking permissions
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                if status { self.setup() }
            }
        case .denied:
            self.alert.toggle()
            return
            
        default:
            return
        }
    }
    
    func setup() {
        do {
            // setting config
            self.session.beginConfiguration()
            
            let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            let input = try AVCaptureDeviceInput(device: device!)
            
            if self.session.canAddInput(input) {
                self.session.addInput(input)
            }
            
            if self.session.canAddOutput(self.output) {
                self.session.addOutput(self.output)
            }
            
            // finishing config
            self.session.commitConfiguration()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func takePicture() {
        
        self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        
        DispatchQueue.global(qos: .background).async {
            self.session.stopRunning()
            
            DispatchQueue.main.async {
                withAnimation { self.isTaken.toggle() }
            }
        }
    }
    
    func retry() {
        DispatchQueue.global(qos: .background).async {
            
            self.session.startRunning()
            
            DispatchQueue.main.async {
                withAnimation { self.isTaken.toggle() }
                
                // Clear Variables
                self.isSaved = false
                self.imageData = Data(count: 0)
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil { return }
        
        print("Photo taken")
        
        // Picture Taken
        guard let imageData = photo.fileDataRepresentation() else { return }
        self.imageData = imageData
        
        print(imageData)
    }
    
    func savePhoto( petID: String ) {
        guard let image = UIImage(data: self.imageData) else { return }
        
        // Saving Image
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        self.isSaved = true
        
        print("Image Saved successfully...")

        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child("images/pets/\( petID )")

        imageRef.putData( image.jpegData(compressionQuality: 0.3)!, metadata: nil ) { (_, error) in
            
            if error != nil {
                print( (error?.localizedDescription)! )
                return
            }
            
            print("Saved on Firebase Storage")
        }
        
    }
}
