//
//  YouLose.swift
//  Muckleshoot-game
//
//  Created by Алкександр Степанов on 28.04.2025.
//

import SwiftUI

struct YouLose: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 100
    @Binding var youLose: Bool
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea().opacity(0.4)
            Image("buyHorseFrame")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.5)
                .overlay(
                    VStack {
                        Text("YOU LOSE")
                            .font(Font.custom("Chewy-Regular", size: screenWidth*0.05))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                       
                        HStack {
                            MenuButton(size: 0.18, text: "MENU")
                                .onTapGesture {
                                    coordinator.navigate(to: .mainMenu)
                                }
                            MenuButton(size: 0.18, text: "")
                                .overlay(
                                    HStack {
                                        Text("RETRY")
                                            .font(Font.custom("Chewy-Regular", size: screenWidth*0.02))
                                            .foregroundColor(.white)
                                            .shadow(color: .black, radius: 2)
                                            .onTapGesture {
                                                youLose.toggle()
                                            }
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
                        }
                    }
                )
        }
    }
}

#Preview {
    YouLose(youLose: .constant(true))
}
