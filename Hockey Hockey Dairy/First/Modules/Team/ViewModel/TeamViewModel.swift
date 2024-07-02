//
//  TeamViewModel.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 27.06.2024.
//

import SwiftUI

class TeamViewModel: ObservableObject {
    @Published var players: [Player] = [] {
        didSet {
            savePlayers()
        }
    }
    
    private let playersFileName = "players.json"
    
    init() {
        loadPlayers()
    }
    
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
    
    func deletePlayerInventary(at playerIndex: Int, at index: Int) {
        guard playerIndex < players.count else { return }
        players[playerIndex].inventory.remove(at: index)
    }
    
    func addPlayerInventary(at playerIndex: Int, inventory: Inventory) {
        guard playerIndex < players.count else { return }
        players[playerIndex].inventory.append(inventory)
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func playersFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(playersFileName)
    }
    
    private func savePlayers() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(players)
            try data.write(to: playersFilePath())
        } catch {
            print("Failed to save players: \(error.localizedDescription)")
        }
    }
    
    private func loadPlayers() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: playersFilePath())
            players = try decoder.decode([Player].self, from: data)
        } catch {
            print("Failed to load players: \(error.localizedDescription)")
        }
    }
}
