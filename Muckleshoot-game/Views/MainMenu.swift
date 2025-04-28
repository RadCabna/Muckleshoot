//
//  MainMenu.swift
//  Muckleshoot-game
//
//  Created by Алкександр Степанов on 22.04.2025.
//

import SwiftUI

struct MainMenu: View {
    @AppStorage("coinCount") var coinCount = 100
    @AppStorage("challengeData") var challengeData = 0
    @State private var remainingTime: TimeInterval = 24 * 60 * 60
    @State private var isButtonActive = false
    @State private var timer: Timer?
    @State private var showBonuses = false
    @State private var challengeGets = false
    @State private var showShop = false
    @State private var showUpgrates = false
    private let savedRemainingTimeKey = "savedRemainingTime"
    private let lastSaveTimestampKey = "lastSaveTimestamp"
    var body: some View {
        ZStack {
            Background(backgroundNumber: 1)
            HStack {
                Image(isButtonActive ? "chestOpen" : "chestClose")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.07)
                    .onTapGesture {
                        challengeData = 0
                    }
                Image("timerFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.12)
                    .overlay(
                        ZStack {
                            if isButtonActive {
                                Text("GET")
                                    .font(Font.custom("Chewy-Regular", size: screenWidth*0.023))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                            } else {
                                Text(buttonText)
                                    .font(Font.custom("Chewy-Regular", size: screenWidth*0.023))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                            }
                        }
                            .offset(y: screenWidth*0.00)
                    )
                    .padding(.bottom, screenHeight*0.02)
                    .onTapGesture {
                        showBonuses.toggle()
                        resetTimer()
                    }
                    .disabled(!isButtonActive)
                Spacer()
                Image("coinCountFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.2)
                    .overlay(
                        Text("\(coinCount)")
                            .font(Font.custom("Chewy-Regular", size: screenWidth*0.023))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                            .offset(x: -screenWidth*0.02)
                    )
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top)
            ZStack {
                Image("challengeFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.3)
                    .overlay(
                        VStack {
                            Text("DAILY CHALLENGE")
                                .font(Font.custom("Chewy-Regular", size: screenWidth*0.02))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2)
                            Text("Run 3 races in a row without a lossloss")
                                .font(Font.custom("Chewy-Regular", size: screenWidth*0.015))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            if challengeData >= 3 && !challengeGets {
                                Image("timerFrame")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.13)
                                    .overlay(
                                        Text("GET")
                                            .font(Font.custom("Chewy-Regular", size: screenWidth*0.023))
                                            .foregroundColor(.white)
                                            .shadow(color: .black, radius: 2)
                                    )
                                    .onTapGesture {
                                        challengeGets = true
                                        coinCount += 100
                                    }
                            } else if challengeGets {
                                Image("timerFrame")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.13)
                                    .overlay(
                                        Text("DONE")
                                            .font(Font.custom("Chewy-Regular", size: screenWidth*0.023))
                                            .foregroundColor(.white)
                                            .shadow(color: .black, radius: 2)
                                    )
                            } else {
                                Image("timerFrame")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.13)
                                    .overlay(
                                        Text("\(challengeData) of 3")
                                            .font(Font.custom("Chewy-Regular", size: screenWidth*0.023))
                                            .foregroundColor(.white)
                                            .shadow(color: .black, radius: 2)
                                    )
                            }
                        }
                            .offset(y: screenHeight*0.04)
                    )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            VStack(spacing: screenHeight*0.07) {
                HStack {
                    MenuButton(size: 0.25, text: "TOURNAMENT")
                        .overlay(
                    Image("timerFrame")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.13)
                        .overlay(
                            HStack {
                                Image("coin")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.02)
                                Text("100")
                                    .font(Font.custom("Chewy-Regular", size: screenWidth*0.023))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                            }
                        )
                        .offset(y: screenHeight*0.08)
                    )
                    MenuButton(size: 0.25, text: "TRAINING")
                }
                HStack {
                    MenuButton(size: 0.25, text: "UPGRADES")
                        .onTapGesture {
                            showUpgrates.toggle()
                        }
                    MenuButton(size: 0.25, text: "STORE")
                        .onTapGesture {
                            showShop.toggle()
                        }
                }
            }
            .offset(x: screenWidth*0.15, y: screenHeight*0.05)
            
            if showShop {
                Store(showShop: $showShop)
            }
            if showUpgrates {
                Upgrades(showUpgrades: $showUpgrates)
            }
        }
        
        .onAppear {
            loadTimerState()
        }
        .onDisappear {
            saveTimerState()
        }
        
    }
    
    private func loadTimerState() {
        let savedRemainingTime = UserDefaults.standard.double(forKey: savedRemainingTimeKey)
        let lastSaveTimestamp = UserDefaults.standard.double(forKey: lastSaveTimestampKey)
        
        if savedRemainingTime > 0 {
            let currentTime = Date().timeIntervalSince1970
            let timePassed = currentTime - lastSaveTimestamp
            
            remainingTime = max(savedRemainingTime - timePassed, 0)
            
            if remainingTime <= 0 {
                isButtonActive = true
                return
            }
        }
        
        startTimer()
    }
    
    private var buttonText: String {
        if isButtonActive {
            return "MENU"
        } else {
            let hours = Int(remainingTime) / 3600
            let minutes = (Int(remainingTime) % 3600) / 60
            let seconds = Int(remainingTime) % 60
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    }
    
    private func startTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                timer?.invalidate()
                isButtonActive = true
            }
        }
    }
    
    private func resetTimer() {
        isButtonActive = false
        remainingTime = 24 * 60 * 60
        startTimer()
    }
    
    private func saveTimerState() {
        UserDefaults.standard.set(remainingTime, forKey: savedRemainingTimeKey)
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: lastSaveTimestampKey)
        
        timer?.invalidate()
    }
    
}

#Preview {
    MainMenu()
}
