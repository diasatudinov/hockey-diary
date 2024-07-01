//
//  Hockey_Hockey_DairyApp.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 26.06.2024.
//

import SwiftUI

@main
struct Hockey_Hockey_DairyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State var isWeb = false
    var body: some Scene {
        WindowGroup {
            if isWeb {
                LoadingUserUIView()
            } else {
                //CalendarUIView()
                LoadingUIView()
                //ContentView()
            }
        }
    }
}
