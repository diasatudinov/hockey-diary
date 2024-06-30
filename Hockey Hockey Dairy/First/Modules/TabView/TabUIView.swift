//
//  TabUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 26.06.2024.
//

import SwiftUI

struct TabUIView: View {
    @ObservedObject var teamVM = TeamViewModel()
    @ObservedObject var inventoryVM = InventoryViewModel()
    @ObservedObject var itemVM = ItemViewModel()
    @ObservedObject var calendarVM = CalendarViewModel()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.tabBar
        
        let tabBarAppearance = UITabBarAppearance()
        
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.white
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.onboardingText
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.onboardingText]
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
    var body: some View {
        TabView {
            TeamUIView(teamVM: teamVM)
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Team")
                }
            
            InventoryUIView(inventoryVM: inventoryVM)
                .tabItem {
                    Image(systemName: "backpack.fill")
                    Text("Inventory")
                }
            
            ShoppingListUIView(itemVM: itemVM)
                .tabItem {
                    Image(systemName: "list.clipboard.fill")
                    Text("Shopping list")
                }
            
            CalendarUIView(calendarVM: calendarVM)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
            
            SettingsUIView(teamVM: teamVM, inventoryVM: inventoryVM, itemVM: itemVM, calendarVM: calendarVM)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
    }
}

#Preview {
    TabUIView()
}
