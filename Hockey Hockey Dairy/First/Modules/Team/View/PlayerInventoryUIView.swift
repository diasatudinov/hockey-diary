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
    @ObservedObject var inventoryVM: InventoryViewModel
    @ObservedObject var teamVM: TeamViewModel
    let standardNavBarHeight = UIScreen.main.bounds.height / 8.6
    @State var inventories: [Inventory]
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
                    
                    ForEach(inventoryVM.inventories, id: \.self) { inventory in
                            InventoryCellUIView(inventory: inventory, selectedImage: inventory.image, name: inventory.name, position: inventory.position, state: .withPlayer, isChosen: inventory.isChosen)
                                .cornerRadius(10)
//                                .onTapGesture {
//                                    //inventory.isChosen.toggle()
//                                    if let index = inventoryVM.inventories.firstIndex(where: { $0.id == inventory.id }) {
//                                        inventoryVM.toggleInventory(at: index)
//                                    }
//                                }
                    }
                        
                } else {
                    ForEach(teamVM.players[index].inventory, id: \.self) { _ in
                        if let index = inventoryVM.inventories.firstIndex(where: { $0.position.uppercased() == teamVM.players[index].position.uppercased() || $0.position.uppercased() == "all positions".uppercased() ||  $0.position.uppercased() == "all".uppercased()}) {
                            let inventory = inventories[index]

                            InventoryCellUIView(selectedImage: inventory.image, name: inventory.name, position: inventory.position, state: .withPlayer, isChosen: inventory.isChosen)
                                .cornerRadius(10)
//                                .onTapGesture {
//                                    if let index = inventoryVM.inventories.firstIndex(where: { $0.id == inventory.id }) {
//                                        inventoryVM.toggleInventory(at: index)
//                                    }
//                                }
                            
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
//        .onAppear{
//            if inventories.isEmpty {
//                inventories = inventoryVM.inventories
//            }
//        }
        
    }
    
}

#Preview {
    PlayerInventoryUIView(inventoryVM: InventoryViewModel(), teamVM: TeamViewModel(), inventories: [
        Inventory(name: "aaa", position: "asdsad", isChosen: false),
        Inventory(name: "aaa", position: "asdsad", isChosen: false),
        Inventory(name: "aaa", position: "asdsad", isChosen: false),
        Inventory(name: "aaa", position: "asdsad", isChosen: false)])
}
