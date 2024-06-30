//
//  ItemViewModel.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 29.06.2024.
//

import SwiftUI


class ItemViewModel: ObservableObject {
    @Published var items: [ShoppingItem] = [
        ShoppingItem(name: "Gloves", position: "Striker", price: "250"),
        ShoppingItem(name: "Helmet", position: "All positions", price: "100"),
        ShoppingItem(name: "Shirt", position: "Striker", price: "350"),
                     ShoppingItem(name: "Gloves", position: "Striker", price: "250"),
                     ShoppingItem(name: "Helmet", position: "All positions", price: "100"),
                     ShoppingItem(name: "Shirt", position: "Striker", price: "350"),
                                  ShoppingItem(name: "Gloves", position: "Striker", price: "250"),
                                  ShoppingItem(name: "Helmet", position: "All positions", price: "100"),
                                  ShoppingItem(name: "Shirt", position: "Striker", price: "350")
    ]
    
    func addItem(_ inventory: ShoppingItem) {
        items.append(inventory)
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
    
}
