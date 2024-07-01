//
//  LoadingUserUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 26.06.2024.
//

import SwiftUI
import StoreKit
import OneSignalFramework


struct LoadingUserUIView: View {
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    @State private var isLoadingView: Bool = true
    @State private var isNotificationView: Bool = true
    @State private var pageNum: Int = 1
    
    var body: some View {
        if pageNum < 3 {
            ZStack {
                Image(isLoadingView ? "background2" : "background3")
                    .resizable()
                    .ignoresSafeArea()
                if isLoadingView {
                    Image("logo2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 230)
                    
                    VStack {
                        Spacer()
                        ProgressView(value: progress, total: 100)
                            .progressViewStyle(LinearProgressViewStyle())
                            .scaleEffect(y: 2.5, anchor: .center)
                            .padding(.horizontal, 120)
                            .padding(.bottom, 80)
                        
                    }
                    .onAppear {
                        startTimer()
                    }
                    .onDisappear {
                        timer?.invalidate()
                    }
                } else {
                    ZStack {
                        VStack {
                            Spacer()
                            switch pageNum {
                            case 1: Image("logoScreen")
                                    .resizable()
                                    .frame(height: UIScreen.main.bounds.height * 2/2.75)
                                    .ignoresSafeArea()
                            case 2: Image("ratings")
                                    .resizable()
                                    .frame(height: UIScreen.main.bounds.height * 2/2.75)
                                    .ignoresSafeArea()
                            default:
                                Image("notification")
                                    .resizable()
                                    .frame(height: UIScreen.main.bounds.height * 2/2.75)
                                    .ignoresSafeArea()
                            }
                            
                        }.padding(.bottom, -UIScreen.main.bounds.height * 1/25)
                        VStack {
                            HStack(spacing: 8) {
                                Rectangle()
                                    .fill(pageNum == 1 ? Color.blue : Color.blue.opacity(0.3))
                                    .frame(width: 72, height: 6)
                                    .cornerRadius(21)
                                
                                Rectangle()
                                    .fill(pageNum == 2 ? Color.blue : Color.blue.opacity(0.3))
                                    .frame(width: 72, height: 6)
                                    .cornerRadius(21)
                                
                            }
                            .padding()
                            switch pageNum {
                            case 1:
                                Text("Buy and take profit")
                                    .font(.title)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color("onboardingTextColor", bundle: nil))
                                    .padding(.bottom, 10)
                                Text("Earn money for your dreams")
                                    .foregroundColor(Color("onboardingTextColor", bundle: nil))
                            case 2:
                                Text("Rate our app in the \nAppStore")
                                    .font(.title)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .frame(height: 70)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color("onboardingTextColor", bundle: nil))
                                Text("Help make the app even better")
                                    .foregroundColor(Color("onboardingTextColor", bundle: nil))
                                    .onAppear{
                                        rateApp()
                                    }
                            default:
                                Text("Don’t miss anything")
                                    .font(.title)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 10)
                                Text("Don’t miss the most userful information")
                                    .foregroundColor(.white).opacity(0.7)
                                
                            }
                            
                        }.padding(.bottom, UIScreen.main.bounds.height * 2/2.6)
                        
                        VStack {
                            Spacer()
                            Button {
                                if pageNum < 3 {
                                    pageNum += 1
                                } else {
                                    
                                }
                                
                                
                            } label: {
                                Text("Next")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }.background(Color.blue)
                                .cornerRadius(10)
                                .padding(.horizontal, 24)
                                .padding(.bottom)
                        }
                    }
                }
            }
        } else {
            if isNotificationView {
                ZStack {
                    Image("background3")
                        .resizable()
                        .ignoresSafeArea()
                    
                    ZStack {
                        VStack {
                            Spacer()
                            
                            Image("notification")
                                .resizable()
                                .frame(height: UIScreen.main.bounds.height * 2/2.75)
                                .ignoresSafeArea()
                            
                            
                        }.padding(.bottom, -UIScreen.main.bounds.height * 1/25)
                        VStack {
                            HStack {
                                Spacer()
                                Button {
                                    isNotificationView = false
                                } label: {
                                    Image(systemName: "x.circle.fill")
                                        .font(.system(size: 25))
                                        .foregroundColor(.gray.opacity(0.76))
                                }
                            }.padding(.horizontal, 32)
                            Spacer()
                            Text("Don’t miss anything")
                                .font(.title)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color.onboardingText)
                                .padding(.bottom, 10)
                            Text("Don’t miss the most userful information")
                                .foregroundColor(Color.onboardingText).opacity(0.7)
                            
                            
                            
                        }.padding(.bottom, UIScreen.main.bounds.height * 2/2.6)
                        
                        VStack {
                            Spacer()
                            Button {
                                OneSignal.Notifications.requestPermission({ accepted in
                                    print("User accepted notifications: \(accepted)")
                                }, fallbackToSettings: true)
                            } label: {
                                Text("Enable notidication")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }.background(Color.blue)
                                .cornerRadius(10)
                                .padding(.horizontal, 24)
                                .padding(.bottom)
                        }
                    }
                }
                
            } else {
                WebUIView()
            }
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            if progress < 100 {
                progress += 1
            } else {
                timer.invalidate()
                isLoadingView.toggle()
            }
        }
    }
    
    func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()

        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "appId") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

#Preview {
    LoadingUserUIView()
}
