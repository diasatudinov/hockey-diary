//
//  CalendarUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 29.06.2024.
//

import SwiftUI

struct CalendarUIView: View {
    
    let standardNavBarHeight = UIScreen.main.bounds.height / 5.5
    @ObservedObject var calendarVM: CalendarViewModel
    @State private var selectedDate: Date?
    @State private var selectedGames: [Game]?
    @State private var showSheet = false
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.tabBar)
                        .frame(height: standardNavBarHeight)
                    VStack(spacing: 8) {
                        Spacer()
                        HStack {
                            Text("Game calendar")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                            Spacer()
                        }.padding()
                    }.frame(height: standardNavBarHeight)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(calendarVM.days, id: \.self) { day in
                            CalendarDayUIView(date: day.day, games: day.games, selectedDate: $selectedDate)
                                .onTapGesture {
                                    selectedDate = day.day
                                }
                        }
                    }
                    //.padding()
                }.padding(.top, 1).padding(.bottom, 24)
                
                ZStack {
                    if let index = calendarVM.days.firstIndex(where: { $0.day == selectedDate }) {
                        if !calendarVM.days[index].games.isEmpty {
                            ScrollView {
                                
                                ForEach(Array(calendarVM.days[index].games.enumerated()), id: \.element) { (gameIndex, game) in
                                    
                                    NavigationLink {
                                        UpdateGameUIView(calendarVM: calendarVM, selectedDate: $selectedDate, selectedImage: game.image, date: calendarVM.days[index].games[gameIndex].date, time: game.time, opponent: game.opponentName, location: game.location, index: gameIndex)
                                    } label: {
                                        GameCardUIView(selectedImage: game.image, date: game.date, time: game.time, opponent: game.opponentName, location: game.location)
                                    }
                                    
                                }
                                
                            }
                        } else {
                            VStack {
                                Spacer()
                                Text("Empty")
                                    .foregroundColor(Color.onboardingText)
                                    .font(.system(size: 22, weight: .bold))
                                    .padding(9)
                                Text("You don’t have any games this day")
                                    .foregroundColor(Color.onboardingText).opacity(0.5)
                                    .font(.system(size: 13))
                                Spacer()
                            }
                        }
                    } else {
                        VStack {
                            Spacer()
                            Text("Empty")
                                .foregroundColor(Color.onboardingText)
                                .font(.system(size: 22, weight: .bold))
                                .padding(9)
                            Text("You don’t have any games this day")
                                .foregroundColor(Color.onboardingText).opacity(0.5)
                                .font(.system(size: 13))
                            Spacer()
                        }
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                if selectedDate != nil {
                                    showSheet = true
                                } else {
                                    showAlert = true
                                }
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.white)
                                    .overlay(
                                        Image(systemName: "plus.circle")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(Color.tabBar)
                                    )
                                    .frame(width: 40, height: 40)
                                
                            }.padding()
                                .padding(.bottom)
                        }
                    }
                }
                Spacer()
                
            }
            .padding(.bottom, 76)
            .sheet(isPresented: $showSheet) {
                AddGameUIView(calendarVM: calendarVM, selectedDate: $selectedDate)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Выберите день для добавления игры"),
                      message: Text(""),
                      dismissButton: .default(Text("OK")))
            }
            .ignoresSafeArea()
        }
    }
}
#Preview {
    CalendarUIView(calendarVM: CalendarViewModel())
}
