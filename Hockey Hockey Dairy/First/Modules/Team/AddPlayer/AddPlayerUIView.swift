//
//  AddPlayerUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 27.06.2024.
//

import SwiftUI
import Combine

struct AddPlayerUIView: View {
    @ObservedObject var inventoryVM: InventoryViewModel
    @ObservedObject var teamVM: TeamViewModel
    @Binding var isPresented: Bool
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var name = ""
    @State private var birthDate = ""
    @State private var position = ""
    @State private var newInventory: [Inventory] = []
    
    
    var body: some View {
        NavigationView {
            VStack {
                Rectangle()
                    .frame(width: 36, height: 5)
                    .cornerRadius(100)
                    .opacity(0.25)
                    .padding()
                ZStack {
                    HStack {
                        Button {
                            isPresented = false
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 24)
                                    .foregroundColor(.black).opacity(0.25)
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(Color.onboardingText)
                            }
                        }.padding(.horizontal)
                        Spacer()
                        
                        
                    }
                    
                    HStack {
                        Text("Add player")
                            .fontWeight(.semibold)
                            .font(.system(size: 17))
                            .foregroundColor(Color.onboardingText)
                    }
                }.padding(.bottom, 24)
                
                
                ZStack {
                    Rectangle()
                        .frame(width: 166, height: 166)
                        .cornerRadius(12)
                        .foregroundColor(Color.onboardingText)
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 126, height: 126)
                            .clipShape(Rectangle())
                            .cornerRadius(6)
                    } else {
                        ZStack {
                            Rectangle()
                                .frame(width: 126, height: 126)
                                .cornerRadius(6)
                                .foregroundColor(.white)
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 35, height: 25)
                        }
                    }
                    
                }.padding(.bottom, 24)
                    .onTapGesture {
                        //BrowseViewControllerStrangeThing()
                        isShowingImagePicker = true
                    }
                VStack(spacing: 12) {
                    ZStack(alignment: .leading) {
                        
                        TextField("", text: $name)
                            .padding()
                            .background(Color.onboardingText)
                            .foregroundColor(.white)
                            .font(.system(size: 17, weight: .bold))
                            .cornerRadius(10)
                        if name.isEmpty {
                            Text("Name")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 16)
                                .allowsHitTesting(false)
                        }
                    }
                    
                    ZStack(alignment: .leading) {
                        
                        TextField("", text: $birthDate)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color.onboardingText)
                            .foregroundColor(.white)
                            .font(.system(size: 17, weight: .bold))
                            .cornerRadius(10)
                            .onReceive(Just(birthDate)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                let formatted = formatInputDate(filtered)
                                if formatted != newValue {
                                    self.birthDate = formatted
                                }
                            }
                        if birthDate.isEmpty {
                            Text("Date of birth")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 16)
                                .allowsHitTesting(false)
                        }
                    }
                    
                    
                    ZStack(alignment: .leading) {
                        
                        TextField("", text: $position)
                            .padding()
                            .background(Color.onboardingText)
                            .foregroundColor(.white)
                            .font(.system(size: 17, weight: .bold))
                            .cornerRadius(10)
                        if position.isEmpty {
                            Text("Position")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 16)
                                .allowsHitTesting(false)
                        }
                    }
                    
                }.padding(.horizontal)
                    .padding(.bottom, 24)
                
                
                NavigationLink {
                    PlayerInventoryUIView(inventoryVM: inventoryVM, teamVM: teamVM, inventories: newInventory)
                } label: {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 54)
                            .foregroundColor(Color.onboardingText)
                            .font(.system(size: 17, weight: .bold))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        HStack {
                            Text("Inventory")
                            Spacer()
                            Image(systemName: "chevron.forward")
                        }
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                    }
                }
                
                Spacer()
                Button {
                    if !name.isEmpty && !birthDate.isEmpty && !position.isEmpty {
                        if let image = selectedImage {
                            teamVM.addPlayer(Player(imageData: image.jpegData(compressionQuality: 1.0), name: name, birthDate: birthDate, position: position, inventory: newInventory))
                           
                        } else {
                            teamVM.addPlayer(Player(imageData: nil, name: name, birthDate: birthDate, position: position, inventory: newInventory))
                            
                        }
                        isPresented = false
                    }
                } label: {
                    ZStack(alignment: .center) {
                        Rectangle()
                            .frame(height: 54)
                            .foregroundColor(Color.tabBar)
                            .font(.system(size: 17, weight: .bold))
                            .cornerRadius(16)
                            .padding(.horizontal)
                        Text("Save")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.white)
                    }
                }.padding(.bottom)
                
            }.sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage, isPresented: $isShowingImagePicker)
            }
        }
    }
    
    func loadImage() {
        if let selectedImage = selectedImage {
            print("Selected image size: \(selectedImage.size)")
        }
    }
    
    func formatInputDate(_ input: String) -> String {
            var formattedString = ""
            let digits = input.prefix(8) // Limit input to 8 digits
            
            if digits.count > 0 {
                formattedString.append(contentsOf: digits.prefix(2))
                if digits.count > 2 {
                    formattedString.append(".")
                }
            }
            
            if digits.count > 2 {
                let start = digits.index(digits.startIndex, offsetBy: 2)
                let end = digits.index(digits.startIndex, offsetBy: min(4, digits.count))
                formattedString.append(contentsOf: digits[start..<end])
                if digits.count > 4 {
                    formattedString.append(".")
                }
            }
            
            if digits.count > 4 {
                let start = digits.index(digits.startIndex, offsetBy: 4)
                formattedString.append(contentsOf: digits[start...])
            }
            
            return formattedString
        }
}

#Preview {
    AddPlayerUIView(inventoryVM: InventoryViewModel(), teamVM: TeamViewModel(), isPresented: .constant(true))
}

