//
//  AnimalsEnum.swift
//  CalmPets
//
//  Created by Aarón Cervantes Álvarez on 18/06/21.
//

enum AnimalsEnum: String, CaseIterable {
    case perro
    case gato
    case cuyo
    case hurón
    case conejo
    case pato
    
    var name: String {
        return rawValue.capitalized
    }
}
