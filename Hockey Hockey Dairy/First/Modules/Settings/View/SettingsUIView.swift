//
//  SettingsUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 30.06.2024.
//

import SwiftUI

struct SettingsUIView: View {
    @ObservedObject var teamVM: TeamViewModel
    @ObservedObject var inventoryVM: InventoryViewModel
    @ObservedObject var itemVM: ItemViewModel
    @ObservedObject var calendarVM: CalendarViewModel
    let standardNavBarHeight = UIScreen.main.bounds.height / 5.5

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .foregroundColor(.tabBar)
                    .frame(height: standardNavBarHeight)
                VStack {
                    Spacer()
                    HStack {
                        Text("Settings")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                    }.padding(16)
                }.frame(height: standardNavBarHeight)
            }
            
            ScrollView {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.onboardingText)
                        .cornerRadius(10)
                    
                    VStack {
                        Button {
                            
                        } label: {
                            HStack {
                                Image(systemName: "doc.text.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 22))
                                Text("Usage policy")
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .semibold))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                                    .font(.system(size: 17))
                            }.padding()
                        }
                        Rectangle()
                            .foregroundColor(.gray.opacity(0.5))
                            .frame(height: 1)
                            .padding(.leading, 50)
                            
                        Button {
                            
                        } label: {
                            HStack {
                                Image(systemName: "square.and.arrow.up.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 22))
                                Text("Share App")
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .semibold))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                                    .font(.system(size: 17))
                            }.padding()
                        }
                        Rectangle()
                            .foregroundColor(.gray.opacity(0.5))
                            .frame(height: 1)
                            .padding(.leading, 50)
                        
                        Button {
                            
                        } label: {
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 22))
                                Text("Rate Us")
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .semibold))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                                    .font(.system(size: 17))
                            }.padding()
                        }
                        Rectangle()
                            .foregroundColor(.gray.opacity(0.5))
                            .frame(height: 1)
                            .padding(.leading, 50)
                    }
                }.padding()
            }
            Spacer()
            Button {
                teamVM.players = []
                inventoryVM.inventories = []
                itemVM.items = []
                for index in calendarVM.days.indices {
                    calendarVM.days[index].games.removeAll()
                }
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.onboardingText)
                        .cornerRadius(16)
                        .frame(height: 50)
                    Text("Reset progress")
                        .foregroundColor(.white)
                        .font(.system(size: 17, weight: .semibold))
                }
            }.padding(.horizontal)
        }.padding(.bottom, 96)
            .ignoresSafeArea()
    }
}

#Preview {
    SettingsUIView(teamVM: TeamViewModel(), inventoryVM: InventoryViewModel(), itemVM: ItemViewModel(), calendarVM: CalendarViewModel())
}
