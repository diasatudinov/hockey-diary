//
//  InventoryModel.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 27.06.2024.
//

import SwiftUI

struct Inventory: Identifiable, Hashable {
    let id = UUID()
    var image: UIImage?
    var name: String
    var position: String
    var isChosen: Bool = false
}

