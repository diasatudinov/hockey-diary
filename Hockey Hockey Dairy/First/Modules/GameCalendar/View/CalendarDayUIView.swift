//
//  CalendarDayUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 29.06.2024.
//

import SwiftUI

struct CalendarDayUIView: View {
    let date: Date
    var games: [Game]
    @Binding var selectedDate: Date?
    
    var body: some View {
        
            HStack {
                VStack {
                    Text(date.formattedDay())
                        .font(.system(size: 20, weight: .bold))
                        .font(.headline)
                    Text(date.formattedMonth())
                        .font(.system(size: 13))
                        .font(.caption)
                        
//                    ForEach(games) { game in
//                        Text(game.teamName)
//                            .font(.caption)
//                    }
                }.foregroundColor(selectedDate == date ? .white : .white.opacity(0.2))
                .padding()
                Rectangle()
                    .frame(width: 1, height: 32)
                    .foregroundColor(.white.opacity(0.2))
                
            }
                .background(Color.tabBar)
    }
}

#Preview {
    CalendarDayUIView(date: Date(), games: [], selectedDate: .constant(nil))
}
