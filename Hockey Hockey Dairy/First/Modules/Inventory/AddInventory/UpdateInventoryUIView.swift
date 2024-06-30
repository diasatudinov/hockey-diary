//
//  UpdateInventoryUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 28.06.2024.
//

import SwiftUI

struct UpdateInventoryUIView: View {
    @ObservedObject var inventoryVM: InventoryViewModel
    @Binding var isPresented: Bool
    @State private var isShowingImagePicker = false
    @State var selectedImage: UIImage?
    @State var name: String
    @State var position: String
    @State var index: Int
    var body: some View {
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
                    Text(name)
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
                        Text("What element")
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
                        Text("Which position")
                            .foregroundColor(.gray)
                            .padding(.horizontal, 16)
                            .allowsHitTesting(false)
                    }
                }
                
            }.padding(.horizontal)
                .padding(.bottom, 24)
            
            Spacer()
            Button {
                if !name.isEmpty && !position.isEmpty {
                    if let image = selectedImage {
                        inventoryVM.updateInventory(at: index, newImage: image, newName: name, newPosition: position)
                    } else {
                        inventoryVM.updateInventory(at: index, newImage: selectedImage, newName: name, newPosition: position)
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
    
    func loadImage() {
        if let selectedImage = selectedImage {
            print("Selected image size: \(selectedImage.size)")
        }
    }
}

#Preview {
    UpdateInventoryUIView(inventoryVM: InventoryViewModel(), isPresented: .constant(true), name: "AAA", position: "AAAA", index: 0)
}
