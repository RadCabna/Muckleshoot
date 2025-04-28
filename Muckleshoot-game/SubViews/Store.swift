//
//  Store.swift
//  Muckleshoot-game
//
//  Created by Алкександр Степанов on 28.04.2025.
//

import SwiftUI

struct Store: View {
    @AppStorage("coinCount") var coinCount = 100
    @State private var shopItemsArray = Arrays.shopItemsArray
    @Binding var showShop: Bool
    @State private var showHorse = false
    @State private var selectedHorseNumber = 0
    var body: some View {
        ZStack {
            Background(backgroundNumber: 3)
            HStack {
                Image("arrowBack")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.07)
                    .onTapGesture {
                        showShop.toggle()
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
                .overlay(
                    HStack(spacing: screenWidth*0.02) {
                        ForEach(0..<shopItemsArray.count, id:\.self) { item in
                            VStack {
                                Image(shopItemsArray[item].name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.13)
                                    .overlay(
                                        Text("\(shopItemsArray[item].horseName)")
                                            .font(Font.custom("Chewy-Regular", size: screenWidth*0.03))
                                            .foregroundColor(.white)
                                            .shadow(color: .black, radius: 2)
                                            .offset(y: screenHeight*0.12)
                                    )
                                Image("menuButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.12)
                                    .overlay(
                                        HStack {
                                            Image("coin")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.02)
                                            Text("\(shopItemsArray[item].cost)")
                                                .font(Font.custom("Chewy-Regular", size: screenWidth*0.02))
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 2)
                                                .shadow(color: .black, radius: 2)

                                        }
                                    )
                                    .onTapGesture {
                                        if coinCount >= shopItemsArray[item].cost {
                                            selectedHorseNumber = item
                                            showHorse.toggle()
                                        }
                                    }
                            }
                        }
                    }
                )
                .offset(y: screenHeight*0.1)
            
            if showHorse {
                BuyNewHorse(horse: $shopItemsArray[selectedHorseNumber], buyNewHorse: $showHorse)
            }
        }
    }
}

#Preview {
    Store(showShop: .constant(true))
}
