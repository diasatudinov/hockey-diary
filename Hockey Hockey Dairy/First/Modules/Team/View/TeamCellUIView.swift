//
//  TeamCellUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 26.06.2024.
//

import SwiftUI

struct TeamCellUIView: View {
    var selectedImage: UIImage?
    var name: String
    var birthDate: String
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 6){
                ZStack {
                    Rectangle()
                        .frame(width: 96, height: 21)
                        .foregroundColor(.white)
                        .cornerRadius(7)
                    Text(birthDate)
                        .font(.system(size: 11))
                        .foregroundColor(.tabBar)
                }
                Text(name)
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .bold()
            }.padding(.leading)
            Spacer()
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 47, height: 47)
                    .clipShape(Rectangle())
                    .cornerRadius(6)
                    .padding(.trailing)
            } else {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .frame(width: 47, height: 47)
                    .foregroundColor(.white)
                    .cornerRadius(6)
                    .padding(.trailing)
            }
        }.frame(height: UIScreen.main.bounds.height / 10)
            .background(Color.onboardingText)
    }
}

#Preview {
    TeamCellUIView(name: "Dias", birthDate: "13.03.1999")
}
