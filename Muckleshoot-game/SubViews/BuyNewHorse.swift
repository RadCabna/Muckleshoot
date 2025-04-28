//
//  BuyNewHorse.swift
//  Muckleshoot-game
//
//  Created by Алкександр Степанов on 28.04.2025.
//

import SwiftUI

struct BuyNewHorse: View {
    @AppStorage("coinCount") var coinCount = 100
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
            Image("buyHorseFrame")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.5)
                .overlay(
                    VStack {
                        Image(horse.name)
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.15)
                            .overlay(
                                Text("\(horse.horseName)")
                                    .font(Font.custom("Chewy-Regular", size: screenWidth*0.03))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                                    .offset(y: screenHeight*0.14)
                            )
                        Image("menuButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.15)
                            .overlay(
                                HStack {
                                    Image("coin")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.02)
                                    Text("\(horse.cost)")
                                        .font(Font.custom("Chewy-Regular", size: screenWidth*0.02))
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 2)
                                        .shadow(color: .black, radius: 2)

                                }
                            )
                    }
                        .offset(y: screenHeight*0.05)
                )
        }
    }
}

#Preview {
    BuyNewHorse(horse: .constant(ShopItem(name: "horseCard1", cost: 300, horseName: "Blaze")), buyNewHorse: .constant(true))
}
