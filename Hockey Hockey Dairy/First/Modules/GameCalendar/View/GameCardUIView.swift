//
//  GameCardUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 29.06.2024.
//

import SwiftUI

struct GameCardUIView: View {
    var selectedImage: UIImage?
    @State var date: String
    @State var time: String
    @State var opponent: String
    @State var location: String
    
    
    var body: some View {
        VStack {
            Text("Game vs \(opponent)")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .padding()
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
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
                        .foregroundColor(Color.onboardingText)
                        .cornerRadius(6)
                }
            }.padding(.bottom, 12)
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: 159)
                    .cornerRadius(10)
                    .padding(.horizontal)
                VStack(alignment: .leading) {
                    ZStack {
                        Text("Date: ")
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                    }
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
                    ZStack {
                        Text(date)
                            .fontWeight(.semibold)
                            .padding(.leading, 80)
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0))
                    Text(time)
                        .fontWeight(.semibold)
                        .padding(.leading, 80)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0))                  
                    Text(opponent)
                        .fontWeight(.semibold)
                        .padding(.leading, 120)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0))
                    Text(location)
                        .fontWeight(.semibold)
                        .padding(.leading, 115)
                }.frame(height: 135).foregroundColor(Color.onboardingText)
            }
            Spacer()
        }
        .frame(height: 428)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color.onboardingText)
        .cornerRadius(14)
        .padding(.horizontal)
    }
}

#Preview {
    GameCardUIView(date: "", time: "", opponent: "", location: "")
}
