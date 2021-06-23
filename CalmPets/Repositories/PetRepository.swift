//
//  PetRepository.swift
//  calmvet
//
//  Created by Aarón Cervantes Álvarez on 04/06/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class PetRepository: ObservableObject {
    private let store = Firestore.firestore()
    private let collection = FirestoreCollectionsEnum.PETS.rawValue.uppercased()
    @Published var pets: [Pet] = []
    @Published var userPets: [Pet] = []
    
    init() {
        get()
    }
    
    init( _ uid: String ) {
        get( uid )
    }
    
    func get() {
        store.collection( collection ).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print( error )
                return
            }
            self.pets = snapshot?.documents.compactMap { try? $0.data(as: Pet.self) } ?? []
        }
    }
    
    func get( _ uid: String ) {
        let collection = FirestoreCollectionsEnum.PETS.rawValue
        store
            .collection( collection )
            .whereField("createdBy", isEqualTo: uid )
            .addSnapshotListener { (snapshot, error) in
                if let error = error {
                    print( error )
                    return
                }
                self.userPets = snapshot?.documents.compactMap { try? $0.data(as: Pet.self) } ?? []
            }
    }
    
    func add(_ pet: Pet) {
        do {
            _ = try store.collection( collection ).addDocument(from: pet)
        } catch {
            fatalError("Adding a pet, failed")
        }
    }
}
