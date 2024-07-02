//
//  AppDelegate.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 01.07.2024.
//

import UIKit
import OneSignalFramework

class AppDelegate: NSObject, UIApplicationDelegate {
    static var apiResponse: ApiResponse?
    var errorMessage: String?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Perform setup tasks here
        
        OneSignal.initialize("api-key", withLaunchOptions: launchOptions)
        let apiService = ApiService()
        
        
        apiService.fetchData { result in
            switch result {
            case .success(let data):
                AppDelegate.apiResponse = data
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
        print("AppDelegate: didFinishLaunchingWithOptions")
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Handle app entering background
        print("AppDelegate: applicationDidEnterBackground")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Handle app entering foreground
        print("AppDelegate: applicationWillEnterForeground")
    }
    
    // Implement other UIApplicationDelegate methods as needed
}
