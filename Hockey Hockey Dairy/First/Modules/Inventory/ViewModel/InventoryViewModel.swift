//
//  InventoryViewModel.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 27.06.2024.
//

import SwiftUI

class InventoryViewModel: ObservableObject {
    @Published var inventories: [Inventory] = [Inventory(name: "Glove", position: "All positions"), Inventory(name: "Arbuz", position: "All positions"), Inventory(name: "Barber", position: "All positions"), Inventory(name: "Clear", position: "All positions"), Inventory(name: "Dollar", position: "All positions"), Inventory(name: "Green", position: "All positions"), Inventory(name: "Chelsea", position: "All positions"), Inventory(name: "Apple", position: "All positions"), Inventory(name: "Car", position: "All positions")]
    
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
    
}
