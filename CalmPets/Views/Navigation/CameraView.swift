//
//  CameraView.swift
//  CalmPets
//
//  Created by Aarón Cervantes Álvarez on 25/06/21.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @Binding var offset: CGFloat
    @Binding var pet: PetModel
    @ObservedObject var petViewModel: PetListViewModel
    @ObservedObject var camera: CameraModel
    
    var body: some View {
        ZStack {
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                
                Spacer()
                
                HStack {
                    if camera.isTaken {
                        
                        Button(action: camera.retry, label: {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle( ))
                        })
                        .padding(.trailing, 10)
                        
                        Spacer()
                        
                        Button(action: takePhoto, label: {
                            Text(camera.isSaved ? "Saved": "Save")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.white)
                                .clipShape(Capsule())
                        })
                        .padding(.leading)
                        
                    } else {
                        Button(action: camera.takePicture , label: {
                            ZStack {
                                Circle()
                                    .fill( Color.white )
                                    .frame(width: 65, height: 65)
                                Circle()
                                    .stroke( Color.white, lineWidth: 2 )
                                    .frame(width: 75, height: 75)
                            }
                        })
                    }
                }
                .frame(height: 75)
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            camera.check()
        }
        
    }
    
    private func takePhoto() {
        
        if !camera.isSaved{
            camera.savePhoto( petID: self.pet.id )
        }
        
    }
    
}


struct CameraPreview: UIViewRepresentable {
    @ObservedObject var camera: CameraModel
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        camera.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
