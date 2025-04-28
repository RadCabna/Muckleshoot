//
//  Upgrades.swift
//  Muckleshoot-game
//
//  Created by Алкександр Степанов on 28.04.2025.
//

import SwiftUI

struct Upgrades: View {
    @AppStorage("coinCount") var coinCount = 100
    @Binding var showUpgrades: Bool
    @State private var yourHosesAray = UserDefaults.standard.array(forKey: "yourHosesAray") as? [[String]] ?? Arrays.yourHorsesArray
    var body: some View {
        ZStack {
            Background(backgroundNumber: 3)
            HStack {
                Image("arrowBack")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.07)
                    .onTapGesture {
                        showUpgrades.toggle()
                    }
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
            Image("shopFrame")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.8)
                .offset(y: screenHeight*0.1)
                .overlay(
                    HStack {
                        ForEach(0..<yourHosesAray.count, id: \.self) { item in
                            VStack(spacing: 0) {
                                Image("menuButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.15)
                                    .overlay(
                                        Text("SELECT")
                                            .font(Font.custom("Chewy-Regular", size: screenWidth*0.02))
                                            .foregroundColor(.white)
                                            .shadow(color: .black, radius: 2)
                                            .shadow(color: .black, radius: 2)
                                    )
                                Image(yourHosesAray[item][0])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.13)
                                    .overlay(
                                        Text("\(yourHosesAray[item][1])")
                                            .font(Font.custom("Chewy-Regular", size: screenWidth*0.03))
                                            .foregroundColor(.white)
                                            .shadow(color: .black, radius: 2)
                                            .offset(y: screenHeight*0.12)
                                    )
                                Text("SPEED +\(yourHosesAray[item][2])%")
                                    .font(Font.custom("Chewy-Regular", size: screenWidth*0.02))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                                Text("STAMINA +\(yourHosesAray[item][3])%")
                                    .font(Font.custom("Chewy-Regular", size: screenWidth*0.02))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                                Image("menuButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.15)
                                    .overlay(
                                        VStack(spacing: 0) {
                                            Text("UPGRADE")
                                                .font(Font.custom("Chewy-Regular", size: screenWidth*0.02))
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 2)
                                                .shadow(color: .black, radius: 2)
                                            HStack {
                                                Image("coin")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.02)
                                                Text("100")
                                                    .font(Font.custom("Chewy-Regular", size: screenWidth*0.02))
                                                    .foregroundColor(.white)
                                                    .shadow(color: .black, radius: 2)
                                                    .shadow(color: .black, radius: 2)

                                            }
                                        }
                                    )
                            }
                            .offset(y: screenHeight*0.08)
                        }
                    }
                )
        }
    }
}

#Preview {
    Upgrades(showUpgrades: .constant(true))
}
