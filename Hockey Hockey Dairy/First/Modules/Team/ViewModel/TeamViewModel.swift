//
//  TeamViewModel.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 27.06.2024.
//

import SwiftUI

class TeamViewModel: ObservableObject {
    @Published var players: [Player] = [Player(name: "Atudinov Dias", birthDate: "13.03.1999", position: "Forward", inventory: [])]
    
    func addPlayer(_ player: Player) {
        players.append(player)
    }

    func updatePlayer(at index: Int, newImage: UIImage?, newName: String, newBirthDate: String, newPosition: String) {
        guard index < players.count else { return }
        players[index].name = newName
        players[index].image = newImage
        players[index].birthDate = newBirthDate
        players[index].position = newPosition
    }
    
    func deletePlayer(at index: Int) {
        guard index < players.count else { return }
        players.remove(at: index)
    }
}
