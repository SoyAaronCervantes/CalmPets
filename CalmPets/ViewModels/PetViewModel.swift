//
//  CardViewModel.swift
//  Calm
//
//  Created by Aarón Cervantes Álvarez on 07/06/21.
//

import Combine

final class PetViewModel: ObservableObject, Identifiable {
    @Published var pet: Pet
    private let petRepository = PetRepository()

    var id = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    init( _ pet: Pet) {
        self.pet = pet
        $pet
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
}
