//
//  LoadingUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 26.06.2024.
//

import SwiftUI

struct LoadingUIView: View {
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    @State private var isLoadingView: Bool = true
    @State private var pageNum: Int = 1
    
    var body: some View {
        if pageNum < 4 {
            ZStack {
                Image("background1")
                    .resizable()
                    .ignoresSafeArea()
                if isLoadingView {
                    Image("logo")
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
                            case 1: Image("appScreen1")
                                    .resizable()
                                    .frame(height: UIScreen.main.bounds.height * 2/2.75)
                                    .ignoresSafeArea()
                            case 2: Image("appScreen2")
                                    .resizable()
                                    .frame(height: UIScreen.main.bounds.height * 2/2.75)
                                    .ignoresSafeArea()
                            case 3: Image("appScreen3")
                                    .resizable()
                                    .frame(height: UIScreen.main.bounds.height * 2/2.75)
                                    .ignoresSafeArea()
                            default:
                                Image("appScreen1")
                                    .resizable()
                                    .frame(height: UIScreen.main.bounds.height * 2/2.75)
                                    .ignoresSafeArea()
                            }
                            
                        }.padding(.bottom, -UIScreen.main.bounds.height * 1/25)
                        VStack {
                            HStack(spacing: 8) {
                                Rectangle()
                                    .fill(pageNum > 0 ? Color.blue : Color.gray)
                                    .frame(width: 72, height: 6)
                                    .cornerRadius(21)
                                
                                Rectangle()
                                    .fill(pageNum > 1 ? Color.blue : Color.gray)
                                    .frame(width: 72, height: 6)
                                    .cornerRadius(21)
                                
                                Rectangle()
                                    .fill(pageNum == 3 ? Color.blue : Color.gray)
                                    .frame(width: 72, height: 6)
                                    .cornerRadius(21)
                            }
                            .padding()
                            switch pageNum {
                            case 1:
                                Text("Manage your team!")
                                    .font(.title)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 10)
                                Text("Be your own trainer!")
                                    .foregroundColor(.white).opacity(0.7)
                            case 2:
                                Text("Explore your own inventory")
                                    .font(.title)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 10)
                                Text("Awesome function")
                                    .foregroundColor(.white).opacity(0.7)
                            case 3:
                                Text("Be in focus with games")
                                    .font(.title)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 10)
                                Text("Fill out the game calendar!")
                                    .foregroundColor(.white).opacity(0.7)
                            default:
                                Text("Manage your team!")
                                    .font(.title)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 10)
                                Text("Be your own trainer!")
                                    .foregroundColor(.white).opacity(0.7)
                                
                            }
                            
                        }.padding(.bottom, UIScreen.main.bounds.height * 2/2.6)
                        
                        VStack {
                            Spacer()
                            Button {
                                if pageNum < 4 {
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
            TabUIView()
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
}

#Preview {
    LoadingUIView()
}
