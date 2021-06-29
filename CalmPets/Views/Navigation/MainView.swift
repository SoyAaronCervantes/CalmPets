//
//  MainView.swift
//  CalmPets
//
//  Created by Aarón Cervantes Álvarez on 17/06/21.
//

import SwiftUI
import Firebase

struct MainView: View {
    @State var offset: CGFloat = 0
    @State var pet = PetModel()
    
    private let user = Auth.auth().currentUser

    var body: some View {
        GeometryReader { reader in

            let frame = reader.frame( in: .global)

            ScrollableTabBar(tabs: ["", "", ""], rect: frame, offset: $offset) {
                HomeView(offset: $offset)
                PetFormView( offset: $offset, pet: $pet, petViewModel: PetListViewModel( uid: user?.uid ?? "" ) )
                CameraView( offset: $offset, pet: $pet, petViewModel: PetListViewModel( uid: user?.uid ?? "" ), camera: CameraModel() )
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
