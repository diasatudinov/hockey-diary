//
//  ItemViewModel.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 29.06.2024.
//

import SwiftUI


class ItemViewModel: ObservableObject {
    @Published var items: [ShoppingItem] = [] {
        didSet {
            saveItems()
        }
    }
    
    private let itemsFileName = "items.json"
    
    init() {
        loadItems()
    }
    
    func addItem(_ item: ShoppingItem) {
        items.append(item)
    }

    func updateItem(at index: Int, newImage: UIImage?, newName: String, newPosition: String, newPrice: String) {
        guard index < items.count else { return }
        items[index].name = newName
        items[index].image = newImage
        items[index].position = newPosition
        items[index].price = newPrice
    }
    
//    func toggleInventory(at index: Int) {
//        items[index].isChosen.toggle()
//    }
    
    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func itemsFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(itemsFileName)
    }
    
    private func saveItems() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(items)
            try data.write(to: itemsFilePath())
        } catch {
            print("Failed to save items: \(error.localizedDescription)")
        }
    }
    
    private func loadItems() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: itemsFilePath())
            items = try decoder.decode([ShoppingItem].self, from: data)
        } catch {
            print("Failed to load items: \(error.localizedDescription)")
        }
    }
    
}
