//
//  TeamModel.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 26.06.2024.
//

import SwiftUI

struct Player: Identifiable, Codable, Hashable {
    let id = UUID()
    var imageData: Data?
    var name: String
    var birthDate: String
    var position: String
    var inventory: [Inventory]
    
    
    enum CodingKeys: String, CodingKey {
        case id, name, imageData, birthDate, position, inventory
    }
    
    var image: UIImage? {
        get {
            guard let data = imageData else { return nil }
            return UIImage(data: data)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 1.0)
        }
    }
    
}


