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
    @AppStorage("selectedHorseIndex") var selectedHorseIndex = 0
    @State private var yourHorsesAray = UserDefaults.standard.array(forKey: "yourHorsesAray") as? [[String]] ?? Arrays.yourHorsesArray
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
//                    .onTapGesture {
//                        UserDefaults.standard.removeObject(forKey: "yourHorsesAray")
//                        coinCount = 100
//                    }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top)
            .padding(.horizontal)
            Image("shopFrame")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.8)
                .offset(y: screenHeight*0.1)
                .overlay(
                        HStack {
                            ForEach(0..<yourHorsesAray.count, id: \.self) { item in
                                VStack(spacing: 0) {
                                    Image("menuButton")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.15)
                                        .overlay(
                                            Text(selectedHorseIndex == item ? "SELECTED" : "SELECT")
                                                .font(Font.custom("Chewy-Regular", size: screenWidth*0.02))
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 2)
                                                .shadow(color: .black, radius: 2)
                                        )
                                        .onTapGesture {
                                            selectedHorseIndex = item
                                        }
                                    Image(yourHorsesAray[item][0])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.13)
                                        .overlay(
                                            Text("\(yourHorsesAray[item][1])")
                                                .font(Font.custom("Chewy-Regular", size: screenWidth*0.03))
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 2)
                                                .offset(y: screenHeight*0.1)
                                        )
                                    Text("SPEED +\(yourHorsesAray[item][2])%")
                                        .font(Font.custom("Chewy-Regular", size: screenWidth*0.02))
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 2)
                                    Text("STAMINA +\(yourHorsesAray[item][3])%")
                                        .font(Font.custom("Chewy-Regular", size: screenWidth*0.02))
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 2)
                                    Image(coinCount >= 100 ? "menuButton" : "disactiveButton")
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
                                                    Text(yourHorsesAray[item][5])
                                                        .font(Font.custom("Chewy-Regular", size: screenWidth*0.02))
                                                        .foregroundColor(.white)
                                                        .shadow(color: .black, radius: 2)
                                                        .shadow(color: .black, radius: 2)
                                                    
                                                }
                                            }
                                        )
                                        .onTapGesture {
                                            updateYourHorse(item: item)
                                        }
                                }
                                .offset(y: screenHeight*0.08)
                            }
                        }
                )
        }
    }
    
    func updateYourHorse(item: Int) {
        if let horseLevel = Int(yourHorsesAray[item][4]),
           let speed = Int(yourHorsesAray[item][2]),
           let stamina = Int(yourHorsesAray[item][3]),
           let cost = Int(yourHorsesAray[item][5])
        {
            if coinCount >= cost && Int(horseLevel) < 3 {
                coinCount -= 100
                yourHorsesAray[item][4] = String(horseLevel + 1)
                yourHorsesAray[item][2] = String(speed + 5)
                yourHorsesAray[item][3] = String(stamina + 5)
                yourHorsesAray[item][5] = String(cost + 100)
            }
            UserDefaults.standard.setValue(yourHorsesAray, forKey: "yourHorsesAray")
        }
    }
    
}

#Preview {
    Upgrades(showUpgrades: .constant(true))
}
