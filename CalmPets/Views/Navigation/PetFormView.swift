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
    @ObservedObject var petViewModel: PetListViewModel
    
    @State var name = ""
    @State var age = ""
    @State var description = ""
    @State var selectedAnimal: AnimalsEnum = .perro
    @State var selectedGenre: GenresEnum = .masculino
    
    @State var showErrors = false

    var body: some View {
        NavigationView {
            VStack {
                
                HStack(spacing: 15) {

                    Button(action: backToPetList, label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor( Color("secondaryColor") )
                            Text("Mascotas")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                    })
                    Spacer()
                    Button(action: hideKeyboard, label: {
                            Image(systemName: "keyboard.chevron.compact.down")
                                .foregroundColor( Color("secondaryColor") )
                    })

                    Button(action: savePet, label: {
                            Text("Guardar")
                                .font(.callout)
                                .fontWeight(.bold)
                                .foregroundColor( Color("secondaryColor") )
                    })
                    .alert(isPresented: $showErrors) {
                        Alert(
                            title: Text("Ocurrió un error"),
                            message: Text("Debes llenar el formulario"),
                            dismissButton: .default(Text("Ok"), action: {
                                self.showErrors.toggle()
                            })
                        )
                    }

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
                    
                    Section( header: Text("¿Qué lo hace tan especial?") ) {
                        TextEditor(text: $description)
                            .frame(height: 150)
                            .lineLimit(5)
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
    
    private func savePet() {

        guard !name.isEmpty || !age.isEmpty else {
            self.showErrors.toggle()

            return
        }

        self.pet = PetModel()
        self.pet.setup()

        self.pet.name = self.name
        self.pet.age = self.age
        self.pet.createdBy = Auth.auth().currentUser!.uid
        self.pet.genre = self.selectedGenre.rawValue
        self.pet.animal = self.selectedAnimal.rawValue

    }
    
    private func backToPetList() {
        hideKeyboard()
        offset = CGFloat(0)
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
