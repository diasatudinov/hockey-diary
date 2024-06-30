//
//  TeamModel.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 26.06.2024.
//

import SwiftUI

struct Player: Identifiable {
    let id = UUID()
    var image: UIImage?
    var name: String
    var birthDate: String
    var position: String
    var inventory: [Inventory]
}

