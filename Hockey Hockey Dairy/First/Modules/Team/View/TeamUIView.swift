//
//  TeamUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 26.06.2024.
//

import SwiftUI

struct TeamUIView: View {
    @ObservedObject var teamVM: TeamViewModel
    @State private var showSheet = false
    let standardNavBarHeight = UIScreen.main.bounds.height / 5.5
    var groupedPlayers: [String: [Player]] {
        Dictionary(grouping: teamVM.players, by: { $0.position })
    }
    init(teamVM: TeamViewModel) {
        // This removes the separator lines for all UITableViews in the app
        self.teamVM = teamVM
        UITableView.appearance().separatorStyle = .none
    }
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.tabBar)
                        .frame(height: standardNavBarHeight)
                    VStack {
                        Spacer()
                        HStack {
                            Text("Team")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                            Spacer()
                            if teamVM.players.isEmpty {
                                Button {
                                    showSheet = true
                                } label: {
                                    Image(systemName: "plus")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                }
                            }
                        }.padding(16)
                    }.frame(height: standardNavBarHeight)
                }
                if !teamVM.players.isEmpty {
                    ScrollView(showsIndicators: false) {
                        ForEach(groupedPlayers.keys.sorted(), id: \.self) { key in
                            Section(header: HStack {
                                Text(key).font(.system(size: 20)).foregroundColor(Color.onboardingText); Spacer(); Button(action: {showSheet = true}, label: {
                                    Image(systemName: "plus.app").resizable().foregroundColor(Color.onboardingText).frame(width: 22)
                                })}.padding(.vertical, 12)) {
                                    let players = groupedPlayers[key]!
                                    ForEach(players.indices, id: \.self) { index in
                                        let player = players[index]
                                        NavigationLink {
                                            UpdatePlayerUIView(player: player, teamVM: teamVM, selectedImage: player.image ,name: player.name, birthDate: player.birthDate, position: player.position, state: .normal, index: index)
                                        } label: {
                                            
                                            TeamCellUIView(selectedImage: player.image, name: player.name, birthDate: player.birthDate)
                                                .border(Color.tabBar.opacity(0.3), width: 1)
                                                .clipShape(CustomCornerRadiusShape(corners: index == 0 ? [.topLeft, .topRight] : [], radius: 10))
                                                .clipShape(CustomCornerRadiusShape(corners: index == players.count - 1 ? [.bottomLeft, .bottomRight] : [], radius: 10))
                                                .padding(.vertical, -4)
                                        }
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 76)
                    
                } else {
                    VStack {
                        Spacer()
                        Text("Empty")
                            .foregroundColor(Color.onboardingText)
                            .font(.system(size: 22, weight: .bold))
                            .padding(9)
                        Text("You don’t have any active trips")
                            .foregroundColor(Color.onboardingText).opacity(0.5)
                            .font(.system(size: 13))
                        Spacer()
                    }
                }
                Spacer()
                
            }
            .sheet(isPresented: $showSheet) {
                // Sheet content
                AddPlayerUIView(teamVM: teamVM, isPresented: $showSheet)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    TeamUIView(teamVM: TeamViewModel())
}

struct CustomCornerRadiusShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
