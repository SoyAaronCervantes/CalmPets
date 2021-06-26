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
    private let store = Firestore.firestore()

    var body: some View {
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
            
            ScrollView {
                
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, edges?.top ?? 15)
        .padding(.bottom, edges?.bottom ?? 15)
    }
    
    private func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
    
}
