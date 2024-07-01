//
//  InventoryViewModel.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 27.06.2024.
//

import SwiftUI

class InventoryViewModel: ObservableObject {
    @Published var inventories: [Inventory] = [] {
        didSet {
            saveInventories()
        }
    }
    
    private let inventoriesFileName = "inventories.json"
    
    init() {
        loadInventories()
    }
    
    func addInventory(_ inventory: Inventory) {
        inventories.append(inventory)
    }

    func updateInventory(at index: Int, newImage: UIImage?, newName: String, newPosition: String) {
        guard index < inventories.count else { return }
        inventories[index].name = newName
        inventories[index].image = newImage
        inventories[index].position = newPosition
    }
    
    func toggleInventory(at index: Int) {
        inventories[index].isChosen.toggle()
    }
    
    func delete(at offsets: IndexSet) {
        inventories.remove(atOffsets: offsets)
    }
    
    func filteredPlayers(for query: String) -> [Inventory] {
        if query.isEmpty {
            return inventories
        } else {
            return inventories.filter { $0.name.lowercased().contains(query.lowercased()) }
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func inventoriesFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(inventoriesFileName)
    }
    
    private func saveInventories() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(inventories)
            try data.write(to: inventoriesFilePath())
        } catch {
            print("Failed to save inventories: \(error.localizedDescription)")
        }
    }
    
    private func loadInventories() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: inventoriesFilePath())
            inventories = try decoder.decode([Inventory].self, from: data)
        } catch {
            print("Failed to load inventories: \(error.localizedDescription)")
        }
    }
}
