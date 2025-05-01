//
//  YouWin.swift
//  Muckleshoot-game
//
//  Created by Алкександр Степанов on 28.04.2025.
//

import SwiftUI

struct YouWin: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("challengeData") var challengeData = 0
    @AppStorage("coinCount") var coinCount = 100
    @Binding var youWin: Bool
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea().opacity(0.4)
            Image("buyHorseFrame")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.5)
                .overlay(
                    VStack {
                        Text("FINISH!")
                            .font(Font.custom("Chewy-Regular", size: screenWidth*0.05))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                        Image("coinCountFrame")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.2)
                            .overlay(
                                Text("+ 200")
                                    .font(Font.custom("Chewy-Regular", size: screenWidth*0.03))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                                    .offset(x: -screenWidth*0.02)
                            )
                        HStack {
                            MenuButton(size: 0.18, text: "MENU")
                                .onTapGesture {
                                    coinCount += 200
                                    coordinator.navigate(to: .mainMenu)
                                }
                            MenuButton(size: 0.18, text: "")
                                .overlay(
                                    HStack {
                                        Text("RETRY")
                                            .font(Font.custom("Chewy-Regular", size: screenWidth*0.02))
                                            .foregroundColor(.white)
                                            .shadow(color: .black, radius: 2)
                                        Image("coin")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenWidth*0.025)
                                        Text("100")
                                            .font(Font.custom("Chewy-Regular", size: screenWidth*0.02))
                                            .foregroundColor(.white)
                                            .shadow(color: .black, radius: 2)
                                    }
                                )
                                .onTapGesture {
                                    coinCount += 100
                                    youWin.toggle()
                                }
                        }
                    }
                )
        }
        
        .onAppear {
            challengeData += 1
            SoundManager.instance.playSound(sound: "winSound")
        }
        
    }
}

#Preview {
    YouWin(youWin: .constant(true))
}
