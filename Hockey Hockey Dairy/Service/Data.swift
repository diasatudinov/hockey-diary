//
//  Data.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 02.07.2024.
//

import Foundation

struct ApiResponse: Codable {
    let isExact: String
    let copyable: String
    let resizable: [String]
    let finished: String
    let focusable: Bool
    let isSimilar: String
    let hasSibling: String
    let isCurrent: String
    let nonreloadable: Bool
    let isUppercase: Int
    let isRandom: Bool

    enum CodingKeys: String, CodingKey {
        case isExact = "is_exact"
        case copyable
        case resizable
        case finished
        case focusable
        case isSimilar = "is_similar"
        case hasSibling = "has_sibling"
        case isCurrent = "is_current"
        case nonreloadable
        case isUppercase = "is_uppercase"
        case isRandom = "is_random"
    }
}
