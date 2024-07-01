//
//  InventoryModel.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 27.06.2024.
//

import SwiftUI

struct Inventory: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var imageData: Data?
    var position: String
    var isChosen: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, name, imageData, position, isChosen
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
