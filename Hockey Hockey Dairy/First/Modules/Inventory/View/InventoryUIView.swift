//
//  InventoryUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 27.06.2024.
//

import SwiftUI

struct InventoryUIView: View {
    @ObservedObject var inventoryVM: InventoryViewModel
    @State private var selectedInventory: Inventory?
    @State private var selectedInventoryIndex: Int?
    @State private var showSheet = false
    @State private var showUpdateSheet = false
    @State private var searchText = ""
    @State var count = 0
//    init(inventoryVM: InventoryViewModel) {
//        self.inventoryVM = inventoryVM
//    }
    let standardNavBarHeight = UIScreen.main.bounds.height / 4
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .foregroundColor(.tabBar)
                    .frame(height: standardNavBarHeight)
                VStack(spacing: 8) {
                    Spacer()
                    HStack {
                        Text("Inventory")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                    }.padding(.horizontal)
                    
                    ZStack(alignment: .leading) {
                        
                        TextField("", text: $searchText)
                            .padding(.vertical, 7)
                            .padding(.horizontal, 35)
                            .background(Color.search)
                            .foregroundColor(.white)
                            .font(.system(size: 17))
                            .cornerRadius(10)
                        
                        HStack{
                            Image(systemName: "magnifyingglass")
                                .padding(.leading, 8)
                                .foregroundColor(.white)
                            if searchText.isEmpty {
                                Text("Search")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 0)
                                    .allowsHitTesting(false)
                            }
                            Spacer()
                            Image(systemName: "mic.fill")
                                .foregroundColor(.white)
                                .padding(.trailing, 8)
                        }
                    }
                        .frame(height: 36)
                        .padding([.horizontal, .bottom])
                }.frame(height: standardNavBarHeight)
            }
            
            ZStack {
                if !inventoryVM.inventories.isEmpty {
                    List {
                        ForEach(filteredPlayers()) { inventory in
                            InventoryCellUIView(selectedImage: inventory.image, name: inventory.name, position: inventory.position, state: .normal, isChosen: false)
                                .cornerRadius(10)
                                .padding(.vertical, -5)
                                .padding(.horizontal, -4)
                                .onTapGesture {
                                    if let index = inventoryVM.inventories.firstIndex(where: { $0.id == inventory.id }) {
                                        selectedInventoryIndex = index
                                        selectedInventory = inventoryVM.inventories[index]
                                        showUpdateSheet = true
                                    }
                                }
                                .onChange(of: selectedInventory) { newValue in
                                    if count == 0 {
                                        showUpdateSheet = true
                                        count = 1
                                    }
                                }
                            //
                        }.onDelete(perform: inventoryVM.delete)
                    }
                    .listStyle(.inset)
                    .padding(.top, 24)
                    .sheet(isPresented: $showUpdateSheet) {
                            UpdateInventoryUIView(inventoryVM: inventoryVM, isPresented: $showUpdateSheet, selectedImage: selectedInventory?.image, name: selectedInventory?.name ?? "", position: selectedInventory?.position ?? "", index: selectedInventoryIndex ?? 0)
                        }
                    
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
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            showSheet = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(.white)  // Fill color
                                        .overlay(
                                            Image(systemName: "plus.circle")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .foregroundColor(Color.tabBar)  // Outline color
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
            AddInventoryUIView(inventoryVM: inventoryVM, isPresented: $showSheet)
        }
        
        
        .ignoresSafeArea()
    }
    
    private func filteredPlayers() -> [Inventory] {
        return inventoryVM.filteredPlayers(for: searchText)
    }
}

#Preview {
    InventoryUIView(inventoryVM: InventoryViewModel())
}
