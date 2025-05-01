//
//  winTraining.swift
//  Muckleshoot-game
//
//  Created by Алкександр Степанов on 30.04.2025.
//

import SwiftUI

struct WinTraining: View {
    @EnvironmentObject var coordinator: Coordinator
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
                                Text("+ 50")
                                    .font(Font.custom("Chewy-Regular", size: screenWidth*0.03))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                                    .offset(x: -screenWidth*0.02)
                            )
                        HStack {
                            MenuButton(size: 0.18, text: "MENU")
                                .onTapGesture {
                                    coinCount += 50
                                    coordinator.navigate(to: .mainMenu)
                                }
                            MenuButton(size: 0.18, text: "RETRY")
                                .onTapGesture {
                                    coinCount += 50
                                    youWin.toggle()
                                }
                        }
                    }
                )
        }
        
        .onAppear {
            SoundManager.instance.playSound(sound: "winSound")
        }
        
    }
}

#Preview {
    WinTraining(youWin: .constant(true))
}
