//
//  Loading.swift
//  Muckleshoot-game
//
//  Created by Алкександр Степанов on 22.04.2025.
//

import SwiftUI

struct Loading: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("levelInfo") var level = false
    @State private var loadingShadowRadius: CGFloat = 0
    @State private var loadingOpacity: CGFloat = 0
    @State private var loadingProgress: CGFloat = 1
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            let isLandscape = width > height
            if isLandscape {
                ZStack {
                    Background()
                    VStack {
                        Text("LOADING...")
                            .font(Font.custom("Chewy-Regular", size: width*0.05))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                            .shadow(color: .black, radius: 2)
                        ZStack {
                            Image("loadingBarBack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: width*0.5)
                            
                            Image("loadingBarFront")
                                .resizable()
                                .scaledToFit()
                                .frame(width: width*0.495)
                                .offset(x: -width*0.5*loadingProgress)
                                .mask(
                                    Image("loadingBarFront")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: width*0.495)                                )
                        }
                    }
                    .offset(y: height*0.35)
                    .opacity(loadingOpacity)
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            } else {
                ZStack {
                    Background()
                    VStack {
                        Text("LOADING...")
                            .font(Font.custom("Chewy-Regular", size: height*0.05))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                            .shadow(color: .black, radius: 2)
                        ZStack {
                            Image("loadingBarBack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: height*0.5)
                            
                            Image("loadingBarFront")
                                .resizable()
                                .scaledToFit()
                                .frame(width: height*0.495)
                                .offset(x: -height*0.5*loadingProgress)
                                .mask(
                                    Image("loadingBarFront")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: height*0.495)                                )
                        }
                    }
                    .opacity(loadingOpacity)
                    .rotationEffect(Angle(degrees: -90))
                    .offset(x: width*0.35)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
            }
        }
        
        .onAppear {
            changeLogoShadowRadiusAnimation()
            loadingProgressAnimation()
        }
        
        .onChange(of: level) { _ in
            if level {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    coordinator.navigate(to: .mainMenu)
                }
            }
        }
        
    }
    
    func loadingProgressAnimation() {
        withAnimation(Animation.easeInOut(duration: 3).delay(1)) {
            loadingProgress = 0
        }
    }
    
    func changeLogoShadowRadiusAnimation() {
        loadingShadowRadius = 0
        withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
            loadingShadowRadius = 10
        }
        withAnimation(Animation.easeInOut(duration: 1.5)) {
            loadingOpacity = 1
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//            coordinator.navigate(to: .mainMenu)
//        }
    }
    
}

#Preview {
    Loading()
}
