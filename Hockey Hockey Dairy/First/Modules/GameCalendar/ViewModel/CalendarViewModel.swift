//
//  CalendarViewModel.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 29.06.2024.
//

import UIKit

class CalendarViewModel: ObservableObject {
    @Published var days: [DayModel] = [] {
        didSet {
            saveDays()
        }
    }
        
    private let daysFileName = "days.json"
    
    init() {
        loadDays()
    }
    
    private func dates() -> [DayModel] {
        let everyDay: [Date] = Date().allDatesForYear()
        
        let dayModels: [DayModel] = everyDay.map { date in
            DayModel(day: date, games: [])
        }
        return dayModels
    }
    
    func addGame(_ game: Game, toDayWithDate date: Date) {
        if let index = days.firstIndex(where: { $0.day == date }) {
            guard index < days.count else { return }
            days[index].games.append(game)
        }
    }
    
    func updateGame(at gameIndex: Int, toDayWithDate date: Date, newImage: UIImage?, newDate: String, newTime: String, newOpponent: String, newLocation: String) {
        
        if let index = days.firstIndex(where: { $0.day == date }) {
            guard gameIndex < days[index].games.count else { return }
            days[index].games[gameIndex].date = newDate
            days[index].games[gameIndex].image = newImage
            days[index].games[gameIndex].time = newTime
            days[index].games[gameIndex].opponentName = newOpponent
            days[index].games[gameIndex].location = newLocation
        }
    }
    
    func deleteGame(at gameIndex: Int, toDayWithDate date: Date) {
        if let index = days.firstIndex(where: { $0.day == date }) {
            days[index].games.remove(at: gameIndex)
            
            
        }
    }
    
    func addGameInfo(at gameIndex: Int, toDayWithDate date: Date, additionalInfo: String) {
        if let index = days.firstIndex(where: { $0.day == date }) {
            guard gameIndex < days[index].games.count else { return }
            days[index].games[gameIndex].additionalInfo.append(additionalInfo)
        }
    }
    
    func getGameInfos(at gameIndex: Int, toDayWithDate date: Date) -> [String] {
        
        if let index = days.firstIndex(where: { $0.day == date }) {
            guard gameIndex < days[index].games.count else { return []}
            return days[index].games[gameIndex].additionalInfo
        }
        return []
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func inventoriesFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(daysFileName)
    }
    
    private func saveDays() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(days)
            try data.write(to: inventoriesFilePath())
        } catch {
            print("Failed to save inventories: \(error.localizedDescription)")
        }
    }
    
    private func loadDays() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: inventoriesFilePath())
            if data.isEmpty {
                days = dates() // Если файл пустой, создаем новый массив
            } else {
                days = try decoder.decode([DayModel].self, from: data)
            }
            //days = try decoder.decode([DayModel].self, from: data)
        } catch {
            print("Failed to load inventories: \(error.localizedDescription)")
        }
    }
}
