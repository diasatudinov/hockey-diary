//
//  ShoppingListUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 29.06.2024.
//

import SwiftUI

struct ShoppingListUIView: View {
    @ObservedObject var itemVM: ItemViewModel
    @State private var selectedItem: ShoppingItem?
    @State private var selectedItemIndex: Int?
    @State private var showSheet = false
    @State private var showUpdateSheet = false
    @State private var searchText = ""
    @State var count = 0

    let standardNavBarHeight = UIScreen.main.bounds.height / 5.5
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .foregroundColor(.tabBar)
                    .frame(height: standardNavBarHeight)
                VStack(spacing: 8) {
                    Spacer()
                    HStack {
                        Text("Shopping list")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                    }.padding()
                }.frame(height: standardNavBarHeight)
            }
            
            ZStack {
                if !itemVM.items.isEmpty {
                    List {
                        ForEach(itemVM.items) { item in
                            InventoryCellUIView(selectedImage: item.image, name: item.name, position: item.position, price: item.price, state: .shopItem, isChosen: .constant(false))
                                .cornerRadius(10)
                                .padding(.vertical, -5)
                                .padding(.horizontal, -4)
                                .onTapGesture {
                                    if let index = itemVM.items.firstIndex(where: { $0.id == item.id }) {
                                        selectedItemIndex = index
                                        selectedItem = itemVM.items[index]
                                        showUpdateSheet = true
                                    }
                                }
                                .onChange(of: selectedItem) { newValue in
                                    if count == 0 {
                                        showUpdateSheet = true
                                        count = 1
                                    }
                                }
                            //
                        }.onDelete(perform: itemVM.delete)
                    }
                    .listStyle(.inset)
                    .padding(.top, 24)
                    .sheet(isPresented: $showUpdateSheet) {
                        UpdateItemUIView(itemVM: itemVM, isPresented: $showUpdateSheet, selectedImage: selectedItem?.image, name: selectedItem?.name ?? "", position: selectedItem?.position ?? "", price: selectedItem?.price ?? "", index: selectedItemIndex ?? 0)
                        
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
            AddItemUIView(itemVM: itemVM, isPresented: $showSheet)
        }
        
        
        .ignoresSafeArea()
    }
}


#Preview {
    ShoppingListUIView(itemVM: ItemViewModel())
}
