//
//  TopBar.swift
//  CalmPets
//
//  Created by Aarón Cervantes Álvarez on 16/06/21.
//

import SwiftUI

struct TopBar: View {
    @Binding var offset: CGFloat
    var title: String
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                offset = rect.width
            }, label: {
                Image(systemName: "plus.app")
                    .font(.title)
                    .foregroundColor( Color("secondaryColor") )
            })
        }
        .padding(.horizontal)
        .overlay(
            Text(title)
                .font(.title2)
                .bold()
        )
    }
}
