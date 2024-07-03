//
//  SwiftUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 03.07.2024.
//

import SwiftUI
import StoreKit

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Button(action: shareApp) {
                Text("Share App")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: rateApp) {
                Text("Rate Us")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
    
    private func shareApp() {
        guard let url = URL(string: "https://apps.apple.com/app/idYOUR_APP_ID") else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        // Present the UIActivityViewController
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityVC, animated: true, completion: nil)
        }
    }
    
    private func rateApp() {
        guard let url = URL(string: "https://apps.apple.com/app/idYOUR_APP_ID?action=write-review") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

#Preview {
    ContentView()
}
