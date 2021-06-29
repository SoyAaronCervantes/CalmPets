//
//  Pet.swift
//  calmvet
//
//  Created by Aarón Cervantes Álvarez on 04/06/21.
//

import FirebaseFirestoreSwift

struct Pet: Identifiable, Codable {
    var id: String
    var name: String
    var description: String
    var createdBy: String
    var age: String
    var animal: String
    var genre: String
}
