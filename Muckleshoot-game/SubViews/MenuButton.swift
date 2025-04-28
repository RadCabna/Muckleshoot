//
//  MenuButton.swift
//  Muckleshoot-game
//
//  Created by Алкександр Степанов on 22.04.2025.
//

import SwiftUI

struct MenuButton: View {
    var size = 0.3
    var text = "Menu"
    var body: some View {
        Image("menuButton")
            .resizable()
            .scaledToFit()
            .frame(width: screenWidth*size)
            .overlay(
                Text(text)
                    .font(Font.custom("Chewy-Regular", size: screenWidth*0.15*size))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2)
            )
    }
}

#Preview {
    MenuButton()
}
