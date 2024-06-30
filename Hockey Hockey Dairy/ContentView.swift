//
//  ContentView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 26.06.2024.
//

import SwiftUI
import UIKit


//struct GameCardView: View {
//    let game: Game
//    
//    var body: some View {
//        VStack {
//            Text(game.teamName)
//                .font(.headline)
//            Text(game.gameDescription)
//                .font(.subheadline)
//            Text(game.date, style: .date)
//                .font(.caption)
//        }
//        .padding()
//        .background(Color.white)
//        .cornerRadius(8)
//        .shadow(radius: 4)
//    }
//}
//
//struct CalendarDayView: View {
//    let date: Date
//    let games: [Game]
//    @Binding var selectedDate: Date?
//    
//    var body: some View {
//        Button(action: {
//            selectedDate = date
//        }) {
//            HStack {
//                VStack {
//                    Text(date.formattedDay())
//                        .font(.system(size: 20, weight: .bold))
//                        .font(.headline)
//                    Text(date.formattedMonth())
//                        .font(.system(size: 13))
//                        .font(.caption)
//                        
////                    ForEach(games) { game in
////                        Text(game.teamName)
////                            .font(.caption)
////                    }
//                }.foregroundColor(selectedDate == date ? .white : .white.opacity(0.2))
//                .padding()
//                Rectangle()
//                    .frame(width: 1, height: 32)
//                    .foregroundColor(.white)
//                
//            }
//                .background(Color.tabBar)
//        }
//    }
//}
//
//
//
//
//struct HorizontalCalendarView: View {
//    let days: [Date]
//    let games: [Game]
//    @Binding var selectedDate: Date?
//    
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 0) {
//                ForEach(days, id: \.self) { day in
//                    let gamesForDay = games.filter { Calendar.current.isDate($0.date, inSameDayAs: day) }
//                    CalendarDayView(date: day, games: gamesForDay, selectedDate: $selectedDate)
//                }
//            }
//            //.padding()
//        }
//    }
//}
//
//
//
//struct AddGameView: View {
//    @Binding var selectedDate: Date?
//    @State private var teamName = ""
//    @State private var gameDescription = ""
//    var addGame: (Game) -> Void
//    @Environment(\.presentationMode) var presentationMode
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextField("Название команды", text: $teamName)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//                TextField("Описание игры", text: $gameDescription)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//                Button(action: {
//                    if let date = selectedDate {
//                        let newGame = Game(date: date, teamName: teamName, gameDescription: gameDescription)
//                        addGame(newGame)
//                        presentationMode.wrappedValue.dismiss()
//                    }
//                }) {
//                    Text("Добавить игру")
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//                    Text("Отмена")
//                        .padding()
//                        .foregroundColor(.red)
//                }
//            }
//            .padding()
//            .navigationTitle("Добавить игру")
//        }
//    }
//}
//
//
//struct ContentView: View {
//    @State private var showTextField = false
//    @State private var additionalInfo = ""
//    @State private var infoList: [String] = []
//    var body: some View {
//        VStack(spacing: 20) {
//            HStack {
//                Text("Доп информация")
//                
//                Button(action: {
//                    self.showTextField.toggle()
//                }) {
//                    Image(systemName: "plus.circle.fill")
//                        .foregroundColor(.blue)
//                        .font(.system(size: 24))
//                }
//            }
//            
//            if showTextField {
//                TextField("Введите информацию", text: $additionalInfo, onCommit: {
//                    if !self.additionalInfo.isEmpty {
//                        self.infoList.append(self.additionalInfo)
//                        self.additionalInfo = ""
//                        self.showTextField = false
//                    }
//                })
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            }
//            
//            List(infoList, id: \.self) { info in
//                Text(info)
//            }
//            
//            Spacer()
//        }
//        .padding()
//    }
//}
//
//


import Combine

// KeyboardResponder to listen for keyboard notifications
final class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0
    private var cancellable: AnyCancellable?

    init() {
        self.cancellable = NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
            .compactMap { notification in
                guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                    return nil
                }
                if notification.name == UIResponder.keyboardWillHideNotification {
                    return CGFloat(0)
                } else {
                    return keyboardFrame.height
                }
            }
            .assign(to: \.currentHeight, on: self)
    }
}

struct ContentView: View {
    @StateObject private var keyboardResponder = KeyboardResponder()
    @State private var text: String = ""

    var body: some View {
        VStack {
            Spacer()
            TextField("Введите текст", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color(UIColor.systemBackground))
                .cornerRadius(8)
                .padding(.horizontal)
        }
        //.padding(.bottom, keyboardResponder.currentHeight)
        .animation(.easeOut(duration: 0.16))
    }
}

#Preview {
    ContentView()
}


//struct Inventory1: Identifiable, Codable {
//    var id = UUID()
//    var name: String
//    var quantity: Int
//    var isHighlighted: Bool = false // Property to store cell color state
//}
//
//// Step 2: InventoryViewModel
//class InventoryViewModel1: ObservableObject {
//    @AppStorage("inventories") private var storedInventories: Data = Data()
//
//    @Published var inventories: [Inventory1] = [] {
//        didSet {
//            saveInventories()
//        }
//    }
//
//    init() {
//        loadInventories()
//    }
//
//    func updateInventoryColor(at index: Int) {
//        inventories[index].isHighlighted.toggle()
//    }
//
//    private func saveInventories() {
//        if let encoded = try? JSONEncoder().encode(inventories) {
//            storedInventories = encoded
//        }
//    }
//
//    private func loadInventories() {
//        if let decoded = try? JSONDecoder().decode([Inventory1].self, from: storedInventories) {
//            inventories = decoded
//        } else {
//            inventories = [
//                Inventory1(name: "Item 1", quantity: 5),
//                Inventory1(name: "Item 2", quantity: 3),
//                Inventory1(name: "Item 3", quantity: 8)
//            ]
//        }
//    }
//}
//
//// Step 3: InventoryUIView
//struct ContentView: View {
//    @ObservedObject var inventoryVM = InventoryViewModel1()
//    @State private var showEditInventoryView = false
//
//    var body: some View {
//        VStack {
//            List {
//                ForEach(inventoryVM.inventories.indices, id: \.self) { index in
//                    HStack {
//                        Text("\(inventoryVM.inventories[index].name), Quantity: \(inventoryVM.inventories[index].quantity)")
//                        Spacer()
//                        Button(action: {
//                            inventoryVM.updateInventoryColor(at: index)
//                        }) {
//                            Text("Change Color")
//                                .padding()
//                                .background(inventoryVM.inventories[index].isHighlighted ? Color.green : Color.red)
//                                .foregroundColor(.white)
//                                .cornerRadius(5)
//                        }
//                    }
//                }
//                .onDelete(perform: { indexSet in
//                    inventoryVM.inventories.remove(atOffsets: indexSet)
//                })
//            }
//
//            Button("Edit Inventory") {
//                showEditInventoryView.toggle()
//            }
//            .sheet(isPresented: $showEditInventoryView) {
//                EditInventoryView(inventories: $inventoryVM.inventories)
//            }
//        }
//        .padding()
//    }
//}
//
//// Step 4: EditInventoryView
//struct EditInventoryView: View {
//    @Binding var inventories: [Inventory1]
//    @Environment(\.presentationMode) var presentationMode
//    @State private var newName: String = ""
//    @State private var newQuantity: String = ""
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                List {
//                    ForEach(inventories.indices, id: \.self) { index in
//                        TextField("Name", text: $inventories[index].name)
//                        TextField("Quantity", value: $inventories[index].quantity, formatter: NumberFormatter())
//                            .keyboardType(.numberPad)
//                    }
//                }
//
//                Button("Done") {
//                    presentationMode.wrappedValue.dismiss()
//                }
//            }
//            .navigationBarItems(trailing: Button("Save") {
//                // Save changes to the selected inventory item
//                presentationMode.wrappedValue.dismiss()
//            })
//        }
//    }
//}
