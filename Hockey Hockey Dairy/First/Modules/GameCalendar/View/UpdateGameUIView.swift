//
//  UpdateGameUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 29.06.2024.
//

import SwiftUI

enum updateGameState {
    case normal
    case updating
}

struct UpdateGameUIView: View {
    let standardNavBarHeight = UIScreen.main.bounds.height / 8.6
    @State var state: updateGameState = .normal
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingImagePicker = false
    @ObservedObject var calendarVM: CalendarViewModel
    @Binding var selectedDate: Date?
    @State var selectedImage: UIImage?
    @State var date: String
    @State var time: String
    @State var opponent: String
    @State var location: String
    @State var index: Int
    
    @State private var showTextField = false
    @State private var additionalInfo = ""
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.tabBar)
                        .frame(height: standardNavBarHeight)
                    VStack {
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
                                        calendarVM.updateGame(at: index, toDayWithDate: selectedDate ?? Date(), newImage: selectedImage, newDate: date, newTime: time, newOpponent: opponent, newLocation: location)
                                        
                                        state = .normal
                                    } label: {
                                        Image(systemName: "checkmark")
                                            .font(.title)
                                            .foregroundColor(.green)
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
                                Button {
                                    if let selectedDate = selectedDate {
                                        calendarVM.deleteGame(at: index, toDayWithDate: selectedDate)
                                    }
                                    state = .normal
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Image(systemName: "trash.fill")
                                        .font(.title)
                                        .foregroundColor(.red)
                                }
                            }.padding(11)
                            HStack{
                                Text("Game vs \(opponent)").foregroundColor(.white).bold()
                            }
                        }
                    }.frame(height: standardNavBarHeight)
                    
                }//.padding(.bottom, 16)
                
                ScrollView {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.onboardingText)
                            .frame(width: 159, height: 159)
                            .cornerRadius(10)
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 121, height: 134)
                                .clipShape(Rectangle())
                                .cornerRadius(6)
                        } else {
                            Image(systemName: "photo.artframe")
                                .resizable()
                                .frame(width: 60, height: 47)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                        }
                    }.padding(.bottom, 12)
                        .onTapGesture {
                            //BrowseViewControllerStrangeThing()
                            if state == .updating {
                                isShowingImagePicker = true
                            }
                        }
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.onboardingText)
                            .frame(height: 216)
                            .cornerRadius(10)
                            .padding(.horizontal)
                        VStack(alignment: .leading) {
                            ZStack {
                                Text("Date: ")
                                    .fontWeight(.semibold)
                                    .padding(.horizontal).padding(.vertical, 6)
                            }
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray)
                            Text("Time:")
                                .fontWeight(.semibold)
                                .padding(.horizontal).padding(.vertical, 6)
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray)
                            Text("Opponent:")
                                .fontWeight(.semibold)
                                .padding(.horizontal).padding(.vertical, 6)
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray)
                            Text("Location:")
                                .fontWeight(.semibold)
                                .padding(.horizontal).padding(.vertical, 6)
                        }.padding(.horizontal).frame(height: 216).foregroundColor(.gray.opacity(0.5))
                        if state == .updating {
                            VStack(alignment: .leading) {
                                TextField("", text: $date)
                                    .background(Color.onboardingText)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .bold))
                                    .padding(.leading, 80)
                                    .padding(.trailing).padding(.vertical, 6)
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.gray.opacity(0))
                                TextField("", text: $time)
                                    .background(Color.onboardingText)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .bold))
                                    .padding(.leading, 80)
                                    .padding(.trailing).padding(.vertical, 6)
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.gray.opacity(0))
                                TextField("", text: $opponent)
                                    .background(Color.onboardingText)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .bold))
                                    .padding(.leading, 120)
                                    .padding(.trailing).padding(.vertical, 6)
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.gray.opacity(0))
                                TextField("", text: $location)
                                    .background(Color.onboardingText)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .bold))
                                    .padding(.leading, 115)
                                    .padding(.trailing).padding(.vertical, 6)
                            }.frame(height: 216).foregroundColor(.white)
                        } else {
                            VStack(alignment: .leading) {
                                Text(date)
                                    .background(Color.onboardingText)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .bold))
                                    .padding(.leading, 80)
                                    .padding(.trailing).padding(.vertical, 6)
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.gray.opacity(0))
                                Text(time)
                                    .background(Color.onboardingText)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .bold))
                                    .padding(.leading, 80)
                                    .padding(.trailing).padding(.vertical, 8)
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.gray.opacity(0))
                                Text(opponent)
                                    .background(Color.onboardingText)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .bold))
                                    .padding(.leading, 120)
                                    .padding(.trailing).padding(.vertical, 6)
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.gray.opacity(0))
                                Text(location)
                                    .background(Color.onboardingText)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .bold))
                                    .padding(.leading, 115)
                                    .padding(.trailing).padding(.vertical, 6)
                            }.frame(height: 216).foregroundColor(.white)
                        }
                        
                    }
                    
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("Additional info")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color.onboardingText)
                            Spacer()
                            Button(action: {
                                self.showTextField.toggle()
                            }) {
                                Image(systemName: "plus.app")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color.onboardingText)
                            }
                        }
                        if let selectedDate = selectedDate {                        ForEach(calendarVM.getGameInfos(at: index, toDayWithDate: selectedDate), id: \.self) { info in
                            
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color.onboardingText)
                                    .cornerRadius(10)
                                Text(info)
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding()
                            }.padding(.top, 12)
                            
                        }
                        }
                        
                    }.padding()
                    
                    
                    
                    
                }
                
                Spacer()
            }.navigationBarBackButtonHidden()
                .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                    ImagePicker(selectedImage: $selectedImage, isPresented: $isShowingImagePicker)
                }
                .ignoresSafeArea()
            VStack {
                Spacer()
                if showTextField {
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.onboardingText)
                            .frame(height: 50)
                        //.frame(height: 50)
                            .cornerRadius(10)
                        TextField("Write some information", text: $additionalInfo).padding(14).padding(.trailing, 20).foregroundColor(.white)
                        
                        
                        HStack {
                            if additionalInfo.isEmpty {
                                Text("Write some information...")
                                    .allowsHitTesting(false)
                            }
                            Spacer()
                            Button {
                                if !additionalInfo.isEmpty {
                                    if let selectedDate = selectedDate {
                                        calendarVM.addGameInfo(at: index, toDayWithDate: selectedDate, additionalInfo: additionalInfo)
                                        additionalInfo = ""
                                        showTextField = false
                                    }
                                }
                            } label: {
                                Image(systemName: "arrowshape.right.fill")
                                    .padding()
                            }
                        }.padding(.leading).foregroundColor(.gray.opacity(0.8))
                            
                        
                    }.padding(.horizontal)
                }
                
            }
        }
    }
    func loadImage() {
        if let selectedImage = selectedImage {
            print("Selected image size: \(selectedImage.size)")
        }
    }
}

#Preview {
    UpdateGameUIView(calendarVM: CalendarViewModel(), selectedDate: .constant(Date()), date: "May 8", time: "7:00", opponent: "MU", location: "London", index: 0)
}
