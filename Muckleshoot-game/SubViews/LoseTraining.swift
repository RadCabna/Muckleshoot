//
//  LoseTraining.swift
//  Muckleshoot-game
//
//  Created by Алкександр Степанов on 30.04.2025.
//

import SwiftUI

struct LoseTraining: View {
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
                                    Text("RETRY")
                                        .font(Font.custom("Chewy-Regular", size: screenWidth*0.027))
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 2)
                                )
                                .onTapGesture {
                                    youLose.toggle()
                                }
                        }
                    }
                )
        }
    }
}

#Preview {
    LoseTraining(youLose: .constant(true))
}
