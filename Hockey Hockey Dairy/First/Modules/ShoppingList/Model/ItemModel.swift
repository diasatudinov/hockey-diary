//
//  ItemModel.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 29.06.2024.
//

import SwiftUI

struct ShoppingItem: Identifiable, Codable, Hashable {
    let id = UUID()
    var imageData: Data?
    var name: String
    var position: String
    var price: String
    
    enum CodingKeys: String, CodingKey {
        case id, imageData, name, position, price
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
