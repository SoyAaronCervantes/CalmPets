//
//  TabBarButton.swift
//  CalmPets
//
//  Created by Aarón Cervantes Álvarez on 16/06/21.
//

import SwiftUI

struct TabBarButton: View {
    var image: String
    @Binding var selectedTab: String
    var body: some View {
        Button(action: { selectedTab = image }, label: {
            Image(systemName: image)
                .font(.title2)
                .foregroundColor( selectedTab == image ? .primary : .secondary)
        })
    }
}

