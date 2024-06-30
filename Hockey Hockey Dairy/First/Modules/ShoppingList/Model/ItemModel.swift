//
//  ItemModel.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 29.06.2024.
//

import SwiftUI

struct ShoppingItem: Identifiable, Hashable {
    let id = UUID()
    var image: UIImage?
    var name: String
    var position: String
    var price: String
}
