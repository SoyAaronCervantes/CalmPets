//
//  PetFormView.swift
//  calmvet
//
//  Created by Aarón Cervantes Álvarez on 25/05/21.
//

import SwiftUI
import UIKit
import Firebase

struct PetFormView: View {
    @Binding var offset: CGFloat
    @Binding var pet: PetModel
    
    @State var name = ""
    @State var age = ""
    @State var selectedAnimal: AnimalsEnum = .perro
    @State var selectedGenre: GenresEnum = .masculino
    
    let store = Firestore.firestore()

    var genres = ["Masculino", "Femenino"]

    var body: some View {
        NavigationView {
            VStack {
                
                HStack(spacing: 15) {
                    Button(action: {
                        offset = CGFloat(0)
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 24, weight: .bold))
                            Text("Mascotas")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                    })
                    
                    Spacer()
                }
                .foregroundColor(.primary)
                .padding()

                Form {
                    Section( header: Text("Datos de la mascota") ) {

                        TextField("Nombre", text: $name)
                        TextField("Edad", text: $age)
                            .keyboardType(.numberPad)

                        Picker(selection: $selectedAnimal, label: Text("¿Qué animal es?")) {
                            ForEach(AnimalsEnum.allCases, id: \.self) { animal in
                                Text( animal.name ).tag(animal)
                            }
                        }
                        
                        Picker(selection: $selectedGenre, label: Text("¿Qué genero tiene?")) {
                            ForEach(GenresEnum.allCases, id: \.self) { genre in
                                Text( genre.name ).tag(genre)
                            }
                        }

                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, edges?.bottom ?? 15)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        
    }
    
    private func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
    
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
