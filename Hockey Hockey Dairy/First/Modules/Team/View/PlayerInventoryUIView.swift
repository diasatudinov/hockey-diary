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
    @Binding var inventories: [Inventory]
    @Environment(\.presentationMode) var presentationMode
    @State var index = 0
    @State var player: Player?
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
                
            }.padding(.bottom, 10)
            
            ScrollView {
                if state == .add {
                    
                    ForEach(inventoryVM.inventories, id: \.self) { inventory in
                        InventoryCellUIView(inventory: inventory, selectedImage: inventory.image, name: inventory.name, position: inventory.position, state: .withPlayer, isChosen: inventory.isChosen)
                            .cornerRadius(10)
                            .onTapGesture {
                                if let index = inventories.firstIndex(where: { $0.id == inventory.id }) {
                                    // Удалить элемент
                                    inventories.remove(at: index)
                                    print("\(inventory.name) REMOVED")
                                } else {
                                    // Добавить элемент
                                    inventories.append(inventory)
                                    print("\(inventory.name) ADDED")
                                }
                                inventoryVM.toggleInventory(at: inventoryVM.inventories.firstIndex(where: { $0.id == inventory.id })!)
                                print("\(inventory.name) PRESSED")
                            }
                    }
                    
                } else {
                    if var player = player {
                        ForEach(inventoryVM.inventories, id: \.self) { inventory in
                            InventoryCellUIView(selectedImage: inventory.image, name: inventory.name, position: inventory.position, state: .withPlayer, isChosen: inventory.isChosen)
                                .cornerRadius(10)
                                .onTapGesture {
                                    //player.inventory.append(inventory)
                                    
                                    if let index = inventories.firstIndex(where: { $0.id == inventory.id }) {
                                        inventories.remove(at: index)
                                        teamVM.updatePlayerInventory(player: player, inventory: inventories)
                                        inventoryVM.updateChosenStatus(with: player.inventory)
                                    } else {
                                        // Добавить элемент
                                        inventories.append(inventory)
                                        teamVM.updatePlayerInventory(player: player, inventory: inventories)
                                        inventoryVM.updateChosenStatus(with: player.inventory)
                                    }
                                    
                                    //inventoryVM.updateChosenStatus(with: inventories)
                                    print(inventories)
                                }
                                .onAppear{
                                    //inventories = player.inventory
                                    inventoryVM.updateChosenStatus(with: player.inventory)
                                }
                            
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 76)
            
            
            Spacer()
            
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
        
    }
    
    func inventoryDelete(at index: Int) {
        guard index < inventories.count - 1 else { return }
        inventories.remove(at: index)
    }
    
}

#Preview {
    PlayerInventoryUIView(inventoryVM: InventoryViewModel(), teamVM: TeamViewModel(), inventories: .constant([
        Inventory(name: "aaa", position: "asdsad", isChosen: false),
        Inventory(name: "aaa", position: "asdsad", isChosen: false),
        Inventory(name: "aaa", position: "asdsad", isChosen: false),
        Inventory(name: "aaa", position: "asdsad", isChosen: false)]))
}
