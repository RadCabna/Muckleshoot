//
//  BuyNewHorse.swift
//  Muckleshoot-game
//
//  Created by Алкександр Степанов on 28.04.2025.
//

import SwiftUI

struct BuyNewHorse: View {
    @AppStorage("coinCount") var coinCount = 100
    @State private var yourHorsesAray = UserDefaults.standard.array(forKey: "yourHorsesAray") as? [[String]] ?? Arrays.yourHorsesArray
    @State private var alreadyBoughtHorsesData = UserDefaults.standard.array(forKey: "alreadyBoughtHorsesData") as? [Int] ?? [0,0,0,0]
    @State private var selectedHorse =  ["horseCard1","Blaze", "5", "5", "0", "100"]
    @Binding var horseIndex: Int
    @Binding var horse: ShopItem
    @Binding var buyNewHorse: Bool
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea().opacity(0.4)
            HStack {
                Image("arrowBack")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.07)
                    .onTapGesture {
                        buyNewHorse.toggle()
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
            .padding(.horizontal)
            Image("buyHorseFrame")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.5)
                .overlay(
                    VStack {
                        HStack(spacing: screenWidth*0.03) {
                            Image(horse.name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.15)
                                .overlay(
                                    Text("\(horse.horseName)")
                                        .font(Font.custom("Chewy-Regular", size: screenWidth*0.03))
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 2)
                                        .offset(y: screenHeight*0.1)
                                )
                            VStack(alignment: .leading, spacing: screenHeight*0.04) {
                                Text("SPEED +5%")
                                    .font(Font.custom("Chewy-Regular", size: screenWidth*0.03))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                                Text("STAMINA +5%")
                                    .font(Font.custom("Chewy-Regular", size: screenWidth*0.03))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                            }
                        }
                        Image(coinCount >= horse.cost && alreadyBoughtHorsesData[horseIndex] == 0 ? "menuButton" : "disactiveButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.2)
                            .overlay(
                                HStack {
                                    Image("coin")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.03)
                                    Text("\(horse.cost)")
                                        .font(Font.custom("Chewy-Regular", size: screenWidth*0.03))
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 2)
                                        .shadow(color: .black, radius: 2)

                                }
                            )
                            .onTapGesture {
                                buyNewItem()
                            }
                    }
                        .offset(y: screenHeight*0.1)
                )
        }
    }
    
    func buyNewItem() {
        if coinCount >= horse.cost && alreadyBoughtHorsesData[horseIndex] == 0{
            coinCount -= horse.cost
            selectedHorse[0] = horse.name
            selectedHorse[1] = horse.horseName
            yourHorsesAray.append(selectedHorse)
            UserDefaults.standard.setValue(yourHorsesAray, forKey: "yourHorsesAray")
            alreadyBoughtHorsesData[horseIndex] = 1
            UserDefaults.standard.setValue(alreadyBoughtHorsesData, forKey: "alreadyBoughtHorsesData")
        }
    }
    
}

#Preview {
    BuyNewHorse(horseIndex: .constant(0), horse: .constant(ShopItem(name: "horseCard1", cost: 300, horseName: "Blaze")), buyNewHorse: .constant(true))
}
