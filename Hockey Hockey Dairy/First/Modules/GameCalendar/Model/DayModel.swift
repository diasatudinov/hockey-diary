//
//  DayModel.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 29.06.2024.
//

import SwiftUI

struct DayModel: Identifiable, Hashable {
    let id = UUID()
    var day: Date
    var games: [Game]
}

struct Game: Identifiable, Hashable {
    let id = UUID()
    var image: UIImage?
    var date: String
    var time: String
    var opponentName: String
    var location: String
    var additionalInfo: [String] = []
}
