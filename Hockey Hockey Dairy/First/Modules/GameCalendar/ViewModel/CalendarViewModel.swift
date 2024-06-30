//
//  CalendarViewModel.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 29.06.2024.
//

import UIKit

class CalendarViewModel: ObservableObject {
    @Published var days: [DayModel] = []
    
    init() {
        days = dates()
    }
    
//    func resetAll() {
//        days.forEach { day in
//            day.games.removeAll()
//        }
//    }
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
//    func addPlayer(_ player: Player) {
//        players.append(player)
//    }
//
//    func updatePlayer(at index: Int, newImage: UIImage?, newName: String, newBirthDate: String, newPosition: String) {
//        guard index < players.count else { return }
//        players[index].name = newName
//        players[index].image = newImage
//        players[index].birthDate = newBirthDate
//        players[index].position = newPosition
//    }
//    
//    func deletePlayer(at index: Int) {
//        guard index < players.count else { return }
//        players.remove(at: index)
//    }
}
