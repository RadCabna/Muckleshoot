//
//  Pause.swift
//  Muckleshoot-game
//
//  Created by Алкександр Степанов on 28.04.2025.
//

import SwiftUI

struct Pause: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 100
    @Binding var showPause: Bool
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea().opacity(0.4)
            Image("buyHorseFrame")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.5)
                .overlay(
                    VStack {
                        Text("PAUSE")
                            .font(Font.custom("Chewy-Regular", size: screenWidth*0.05))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                       
                        HStack {
                            MenuButton(size: 0.18, text: "MENU")
                                .onTapGesture {
                                    coordinator.navigate(to: .mainMenu)
                                }
                            MenuButton(size: 0.18, text: "RESUME")
                                .onTapGesture {
                                    showPause.toggle()
                                }
                        }
                    }
                )
        }
    }
}

#Preview {
    Pause(showPause: .constant(true))
}
