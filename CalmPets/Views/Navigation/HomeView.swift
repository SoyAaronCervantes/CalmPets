//
//  HomeView.swift
//  CalmPets
//
//  Created by Aarón Cervantes Álvarez on 16/06/21.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @State var selectedTab = "tortoise.fill"
    @Environment(\.colorScheme) var scheme
    @Binding var offset: CGFloat

    private let user = Auth.auth().currentUser

    var body: some View {
        TabView(selection: $selectedTab) {

            GeneralPetsView( offset: $offset, petList: PetListViewModel() )
                .padding(.top, 15)
                .tag("house.fill")

            UserPetsView( offset: $offset, petList: PetListViewModel( uid: user?.uid ?? ""  ) )
                .padding(.top, 15)
                .tag("heart.fill")
        }
        .overlay(
            VStack(spacing: 12) {
                Divider()
                    .padding(.horizontal, -15)
                HStack(spacing: 0) {
                    TabBarButton(image: "tortoise.fill", selectedTab: $selectedTab).frame(maxWidth: .infinity)
                    TabBarButton(image: "heart.fill", selectedTab: $selectedTab).frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, edges?.bottom ?? 15 )
            .background( scheme == .dark ? Color.black : Color.white )
            , alignment: .bottom
        )
        .ignoresSafeArea()
    }
}
