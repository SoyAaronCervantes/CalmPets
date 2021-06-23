//
//  PetCard.swift
//  CalmPets
//
//  Created by Aarón Cervantes Álvarez on 16/06/21.
//


import SwiftUI

struct PetCard: View {
    var pet: Pet
    var body: some View {
        VStack( spacing: 15 ) {
            
            Text( pet.name )
                .font(.title2 )
                .padding(.bottom, -10)
            
            Image( systemName: "tortoise.fill" )
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.blue)
                .frame(width: rect.width - 30, height: 300)
                .cornerRadius(15)
            
            HStack(spacing: 15) {
                Text("Edad:")
                    .font( .subheadline )
                    .bold()
                
                Text( pet.age ).font( .body ) + Text(" años")
                Spacer()
            }
            
            VStack(spacing: 15) {
                
                HStack {
                    Text("¿Porqué es tan especial?:")
                        .font( .subheadline )
                        .bold()
                    Spacer()
                }
                
                HStack {
                    Text( pet.description )
                        .font( .body )
                        .lineLimit(4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            
        }
        .padding()
    }
}

