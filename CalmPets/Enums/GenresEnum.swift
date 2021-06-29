//
//  GenresEnum.swift
//  CalmPets
//
//  Created by Aarón Cervantes Álvarez on 27/06/21.
//

enum GenresEnum: String, CaseIterable {
    case masculino
    case femenino
    
    var name: String {
        return rawValue.capitalized
    }
}
