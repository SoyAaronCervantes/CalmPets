//
//  MainView.swift
//  CalmPets
//
//  Created by Aarón Cervantes Álvarez on 17/06/21.
//

import SwiftUI

struct MainView: View {
    @State var offset: CGFloat = 0
    @State var pet = PetModel()

    var body: some View {
        GeometryReader { reader in

            let frame = reader.frame( in: .global)

            ScrollableTabBar(tabs: ["", "", ""], rect: frame, offset: $offset) {
                HomeView(offset: $offset)
                PetFormView(offset: $offset, pet: $pet)
                CameraView( pet: $pet )
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
