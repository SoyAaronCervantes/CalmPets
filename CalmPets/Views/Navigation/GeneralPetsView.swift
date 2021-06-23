//
//  GeneralPetsView.swift
//  CalmPets
//
//  Created by Aarón Cervantes Álvarez on 16/06/21.
//

import SwiftUI

struct GeneralPetsView: View {
    @Binding var offset: CGFloat
    @ObservedObject var petList: PetListViewModel
    var body: some View {
        VStack {
            TopBar( offset: $offset, title: "Mascotas")
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack( spacing: 15 ) {
                    ForEach( petList.petsViewModel ) { model in
                        PetCard( pet: model.pet )
                    }
                }
                .padding(.bottom, 65)
            })
        }
    }
}
