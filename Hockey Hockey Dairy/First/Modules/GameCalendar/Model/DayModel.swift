//
//  DayModel.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 29.06.2024.
//

import SwiftUI

struct DayModel: Identifiable, Hashable, Codable {
    let id = UUID()
    var day: Date
    var games: [Game]
    
    enum CodingKeys: String, CodingKey {
        case id, day, games
    }
}

struct Game: Identifiable, Hashable, Codable {
    let id = UUID()
    var imageData: Data?
    var date: String
    var time: String
    var opponentName: String
    var location: String
    var additionalInfo: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case id, imageData, date, time, opponentName, location, additionalInfo
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
