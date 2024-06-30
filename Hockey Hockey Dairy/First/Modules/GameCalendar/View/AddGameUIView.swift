//
//  AddGameUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 29.06.2024.
//

import SwiftUI

struct AddGameUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var calendarVM: CalendarViewModel
    @Binding var selectedDate: Date?
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State var date: String = ""
    @State var time: String = ""
    @State var opponent: String = ""
    @State var location: String = ""

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
                        presentationMode.wrappedValue.dismiss()
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
                    Text("Add game")
                        .fontWeight(.semibold)
                        .font(.system(size: 17))
                        .foregroundColor(Color.onboardingText)
                }
            }.padding(.bottom, 24)
            
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
                    isShowingImagePicker = true
                }
            ZStack {
                Rectangle()
                    .foregroundColor(Color.onboardingText)
                    .frame(height: 159)
                    .cornerRadius(10)
                    .padding(.horizontal)
                VStack(alignment: .leading) {
                    ZStack {
                        Text("Date: ")
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                    }
//                    ZStack(alignment: .leading) {
//                        HStack {
//                            ZStack {
//                                TextField("", text: $date)
//                                    .padding(.vertical)
//                                    .padding(.leading, 76)
//                                    .background(Color.onboardingText)
//                                    .foregroundColor(.white)
//                                    .font(.system(size: 17, weight: .bold))
//                                    .cornerRadius(10)
//                                HStack {
//                                    Text("Name:")
//                                        .foregroundColor(.gray).opacity(0.5)
//                                        .font(.system(size: 17,weight: .bold))
//                                    Spacer()
//                                }.padding(.horizontal, 16)
//                            }
//                            
//                        }
//                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    Text("Time:")
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    Text("Opponent:")
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    Text("Location:")
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                }.padding(.horizontal).frame(height: 135).foregroundColor(.gray.opacity(0.5))
                VStack(alignment: .leading) {
                    TextField("", text: $date)
                        .background(Color.onboardingText)
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .bold))
                        .padding(.leading, 80)
                        .padding(.trailing)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0))
                    TextField("", text: $time)
                        .background(Color.onboardingText)
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .bold))
                        .padding(.leading, 80)
                        .padding(.trailing)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0))
                    TextField("", text: $opponent)
                        .background(Color.onboardingText)
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .bold))
                        .padding(.leading, 120)
                        .padding(.trailing)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0))
                    TextField("", text: $location)
                        .background(Color.onboardingText)
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .bold))
                        .padding(.leading, 115)
                        .padding(.trailing)
                }.frame(height: 135).foregroundColor(.white)
                
            }
            Spacer()
            Button {
                                
                if !date.isEmpty && !time.isEmpty && !opponent.isEmpty && !location.isEmpty {
                    if let selectedDate = selectedDate {
                        if let image = selectedImage {
                            calendarVM.addGame(Game(image: image, date: date, time: time, opponentName: opponent, location: location, additionalInfo: []), toDayWithDate: selectedDate)
                        } else {
                            calendarVM.addGame(Game(image: nil, date: date, time: time, opponentName: opponent, location: location, additionalInfo: []), toDayWithDate: selectedDate)
                        }
                    }
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                ZStack(alignment: .center) {
                    Rectangle()
                        .frame(height: 54)
                        .foregroundColor(Color.tabBar)
                        .font(.system(size: 17, weight: .bold))
                        .cornerRadius(16)
                        .padding(.horizontal)
                    Text("Add")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                }
            }.padding(.bottom)
            
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .cornerRadius(14)
        .padding(.horizontal)
        .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
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
    AddGameUIView(calendarVM: CalendarViewModel(), selectedDate: .constant(Date()))
}
