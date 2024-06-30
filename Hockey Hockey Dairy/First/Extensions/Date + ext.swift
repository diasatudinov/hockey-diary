//
//  Date + ext.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 30.06.2024.
//

import Foundation

extension Date {
    func allDatesForYear() -> [Date] {
        var dates = [Date]()
        let calendar = Calendar.current
        let startOfYear = calendar.date(from: calendar.dateComponents([.year], from: self))!
        
        for i in 0..<366 {
            if let date = calendar.date(byAdding: .day, value: i, to: startOfYear) {
                dates.append(date)
            }
        }
        return dates
    }
    
    func formattedDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }
    
    func formattedMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: self)
    }
}
