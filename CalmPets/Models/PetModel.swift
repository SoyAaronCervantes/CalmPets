//
//  PetForm.swift
//  calmvet
//
//  Created by Aarón Cervantes Álvarez on 04/06/21.
//

import SwiftUI
import FirebaseFirestore

class PetModel: ObservableObject {
    @Published private var createdAt: Int64 = 0
    @Published var animal = ""
    @Published var age = ""
    @Published var createdBy = ""
    @Published var description = ""
    @Published var genre = ""
    @Published var id = ""
    @Published var name = ""
    
    func setup() {
        let database = Firestore.firestore()

        self.createdAt = currentTimeInMiliseconds()
        self.id = database.collection( FirestoreCollectionsEnum.PETS.rawValue ).document().documentID
    }
    
    private func currentTimeInMiliseconds() -> Int64! {
        let currentTime = Date()
        return Int64( currentTime.timeIntervalSince1970 * 1000 )
    }
}
