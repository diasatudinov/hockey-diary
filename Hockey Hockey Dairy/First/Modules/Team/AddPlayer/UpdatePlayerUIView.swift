//
//  UpdatePlayerUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 27.06.2024.
//

import SwiftUI
import Combine

enum updateState {
    case normal
    case updating
}

struct UpdatePlayerUIView: View {
    @State var player: Player
    @ObservedObject var inventoryVM = InventoryViewModel()
    @ObservedObject var teamVM: TeamViewModel
    let standardNavBarHeight = UIScreen.main.bounds.height / 8.6
    @State private var isShowingImagePicker = false
    @State var selectedImage: UIImage?
    @State var name: String
    @State var birthDate: String
    @State var position: String
    @State var state: updateState
    @State var index: Int
    @Environment(\.presentationMode) var presentationMode

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
                        
                        if state == .updating {
                            Button {
                                teamVM.updatePlayer(at: index, newImage: selectedImage, newName: name, newBirthDate: birthDate, newPosition: position)
                                state = .normal
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "checkmark")
                                    .font(.title)
                                    .foregroundColor(.green)
                            }
                            Button {
                                if let index = teamVM.players.firstIndex(where: { $0.name == player.name && $0.position == player.position }) {
                                    teamVM.deletePlayer(at: index)
                                }
                                state = .normal
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "trash.fill")
                                    .font(.title)
                                    .foregroundColor(.red)
                            }
                        } else {
                            Button {
                                state = .updating
                            } label: {
                                Image(systemName: "square.and.pencil")
                                    .font(.title)
                                    .foregroundColor(Color.onboardingText)
                            }
                        }
                        
                    }.padding(16)
                        HStack{
                            Text(name).foregroundColor(.white).bold()
                        }
                }
                    }.frame(height: standardNavBarHeight)
                
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
                if state == .updating {
                    isShowingImagePicker = true
                }
            }
            VStack(spacing: 12) {
                if state == .normal {
                    ZStack(alignment: .leading) {
                        HStack {
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .frame(height: 54)
                                    .foregroundColor(Color.onboardingText)
                                    .font(.system(size: 17, weight: .bold))
                                    .cornerRadius(10)
                                HStack {
                                    Text(name)
                                    Spacer()
                                    
                                }
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                    
                    ZStack(alignment: .leading) {
                        HStack {
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .frame(height: 54)
                                    .foregroundColor(Color.onboardingText)
                                    .font(.system(size: 17, weight: .bold))
                                    .cornerRadius(10)
                                HStack {
                                    Text(birthDate)
                                    Spacer()
                                    
                                }
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                    
                    
                    ZStack(alignment: .leading) {
                        HStack {
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .frame(height: 54)
                                    .foregroundColor(Color.onboardingText)
                                    .font(.system(size: 17, weight: .bold))
                                    .cornerRadius(10)
                                HStack {
                                    Text(position)
                                    Spacer()
                                    
                                }
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                } else {
                    ZStack(alignment: .leading) {
                        HStack {
                            ZStack {
                                TextField("", text: $name)
                                    .padding(.vertical)
                                    .padding(.leading, 76)
                                    .background(Color.onboardingText)
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .bold))
                                    .cornerRadius(10)
                                HStack {
                                    Text("Name:")
                                        .foregroundColor(.gray).opacity(0.5)
                                        .font(.system(size: 17,weight: .bold))
                                    Spacer()
                                }.padding(.horizontal, 16)
                            }
                            
                        }
                    }
                    
                    ZStack(alignment: .leading) {
                        HStack {
                            ZStack {
                                TextField("", text: $birthDate)
                                    .keyboardType(.numberPad)
                                    .padding(.vertical)
                                    .padding(.leading, 130)
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
                                HStack {
                                    Text("Date of birth:")
                                        .foregroundColor(.gray).opacity(0.5)
                                        .font(.system(size: 17,weight: .bold))
                                    Spacer()
                                }.padding(.horizontal, 16)
                            }
                            
                        }
                    }
                    
                    ZStack(alignment: .leading) {
                        HStack {
                            ZStack {
                                TextField("", text: $position)
                                    .padding(.vertical)
                                    .padding(.leading, 95)
                                    .background(Color.onboardingText)
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .bold))
                                    .cornerRadius(10)
                                HStack {
                                    Text("Position:")
                                        .foregroundColor(.gray).opacity(0.5)
                                        .font(.system(size: 17,weight: .bold))
                                    Spacer()
                                }.padding(.horizontal, 16)
                            }
                            
                        }
                    }
                }
                
            }
            .padding(.horizontal)
            .padding(.bottom, 24)
            
            NavigationLink {
                PlayerInventoryUIView(inventoryVM: inventoryVM, teamVM: teamVM, inventories: $player.inventory, index: index, player: player, state: .update)
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
            
        }.onAppear{
            print("Выбранный", index)
        }
            .navigationBarBackButtonHidden()
        .ignoresSafeArea()
        .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
            ImagePicker(selectedImage: $selectedImage, isPresented: $isShowingImagePicker)
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

//#Preview {
//    UpdatePlayerUIView(player: Player(from: Decoder()), teamVM: TeamViewModel(), name: "AAA", birthDate: "13.03.1999", position: "Forward", state: .normal, index: 0)
//}
