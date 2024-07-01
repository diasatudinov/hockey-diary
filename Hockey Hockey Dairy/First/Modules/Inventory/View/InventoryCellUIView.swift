//
//  InventoryCellUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 28.06.2024.
//

import SwiftUI

enum InventoryState {
    case normal
    case withPlayer
    case shopItem
}

struct InventoryCellUIView: View {
    @State var inventory: Inventory?
    var selectedImage: UIImage?
    var name: String
    var position: String
    var price: String?
    @State var state: InventoryState
    @State var isChosen: Bool
    var body: some View {
        HStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 52, height: 52)
                    .clipShape(Rectangle())
                    .cornerRadius(6)
                    .padding(.leading)
            } else {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .frame(width: 52, height: 52)
                    .foregroundColor(.white)
                    .cornerRadius(6)
                    .padding(.leading)
            }
            
            VStack (alignment: .leading, spacing: 6){
                ZStack {
                    Rectangle()
                        .frame(width: 96, height: 21)
                        .foregroundColor(.white)
                        .cornerRadius(7)
                    Text(position)
                        .font(.system(size: 11))
                        .foregroundColor(.tabBar)
                }
                Text(name)
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .bold()
            }.padding(.leading, 12)
            Spacer()
            if state == .withPlayer {
                Button {
                    if state == .withPlayer {
                        isChosen.toggle()
                        //inventory?.isChosen.toggle()
                    }
                } label: {
                    
                    Image(systemName: "circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor((isChosen ?? false) ? Color.tabBar : Color.onboardingText)  
                        .overlay(
                            Image(systemName: "circle")
                               .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                        )
                        .frame(width: 22, height: 22)
                        .padding(.trailing)
                    
                }
            } else if state == .shopItem {
                if let price = price {
                    Text("$\(price)")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                }
            }
            
        }.frame(height: UIScreen.main.bounds.height / 10)
            .background(isChosen ? Color.chosenInventory : Color.onboardingText)
            .onChange(of: isChosen) { newValue in
                print(isChosen)
            }
    }
}

//#Preview {
//    InventoryCellUIView(investory: Investory(), name: "AAAA", position: "Aaasadadasdasd", price: "100",state: .shopItem, isChosen: false)
//}
