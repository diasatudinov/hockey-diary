//
//  PlayerInventoryUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 28.06.2024.
//

import SwiftUI

enum PlayerInventoryState {
    case add
    case update
}

struct PlayerInventoryUIView: View {
    @ObservedObject var inventoryVM = InventoryViewModel()
    @ObservedObject var teamVM: TeamViewModel
    let standardNavBarHeight = UIScreen.main.bounds.height / 8.6
    @Binding var inventories: [Inventory]
    @Environment(\.presentationMode) var presentationMode
    @State var index = 0
    @State var state: PlayerInventoryState = .add
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.tabBar)
                    .frame(height: standardNavBarHeight)
                VStack {
                    Button("Go to Detail View") {
                        presentationMode.wrappedValue.dismiss()
                        
                    }
                    Spacer()
                    ZStack {
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                HStack{
                                    Image(systemName: "chevron.left")
                                    Text("Back")
                                }
                                .font(.system(size: 20,weight: .semibold)).foregroundColor(Color.onboardingText)
                            }
                            Spacer()
                            
                            
                            
                        }.padding(16)
                        HStack{
                            Text("Inventory").foregroundColor(.white).bold()
                        }
                    }
                }.frame(height: standardNavBarHeight)
                
            }.padding(.bottom, 24)
            
            ScrollView {
                if state == .add {
                    ForEach(inventories.indices, id: \.self) { index in
                        let inventory = inventories[index]
                        InventoryCellUIView(selectedImage: inventory.image, name: inventory.name, position: inventory.position, state: .withPlayer, isChosen: $inventories[index].isChosen)
                            .cornerRadius(10)
                            .onTapGesture {
                                inventories[index].isChosen.toggle()
                            }
                        
                    }
                } else {
                    ForEach(teamVM.players[index].inventory.indices, id: \.self) { index in
                        let inventory = inventories[index]
                        InventoryCellUIView(selectedImage: inventory.image, name: inventory.name, position: inventory.position, state: .withPlayer, isChosen: $inventories[index].isChosen)
                            .cornerRadius(10)
                            .onTapGesture {
                                inventories[index].isChosen.toggle()
                            }
                        
                    }
                }
                
            }
            .padding(.horizontal)
            .padding(.bottom, 24)
            
           
            Spacer()
            
        }
            .navigationBarBackButtonHidden()
        .ignoresSafeArea()
        .onAppear{
            if inventories.isEmpty {
                inventories = inventoryVM.inventories
            }
        }
        
    }
    
}

#Preview {
    PlayerInventoryUIView(teamVM: TeamViewModel(), inventories: .constant([
        Inventory(name: "aaa", position: "asdsad", isChosen: false),
        Inventory(name: "aaa", position: "asdsad", isChosen: false),
        Inventory(name: "aaa", position: "asdsad", isChosen: false),
        Inventory(name: "aaa", position: "asdsad", isChosen: false)]))
}
