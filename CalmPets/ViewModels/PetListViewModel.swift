//
//  PetListViewModel.swift
//  calmvet
//
//  Created by Aarón Cervantes Álvarez on 04/06/21.
//

import SwiftUI
import Combine

final class PetListViewModel: ObservableObject {
    @Published var petRepository = PetRepository()
    @Published var petsViewModel: [PetViewModel] = []
    @Published var userPetsViewModel: [PetViewModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        petRepository = PetRepository()

        petRepository.$pets
            .map{ pets in pets.map(PetViewModel.init) }
            .assign(to: \.petsViewModel, on: self)
            .store(in: &cancellables)
    }
    
    init( uid: String ) {
        petRepository = PetRepository(uid)

        petRepository.$userPets
            .map{ pets in pets.map(PetViewModel.init) }
            .assign(to: \.userPetsViewModel, on: self)
            .store(in: &cancellables)
    }
    
    func add( _ pet: Pet ) {
        petRepository.add(pet)
    }

}
