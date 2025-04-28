//
//  Game.swift
//  Muckleshoot-game
//
//  Created by Алкександр Степанов on 22.04.2025.
//

import SwiftUI

struct Game: View {
    @State private var boostOn = false
    @State private var startRun = false
    @State private var horseJump = false
    @State private var showPause = false
    @State private var youLose = false
    @State private var youWin = false
    @State private var runProgress: CGFloat = 1
    @State private var stamina: CGFloat = 0
    @State private var horseBoostOffset: CGFloat = 0
    @State private var horseVerticalOffset: CGFloat = 0
    @State private var trackOffset: CGFloat = 0
    @State private var trackTimer: Timer?
    @State private var objectsTimer: Timer?
    @State private var progressTimer: Timer?
    @State private var objectsOffset: CGFloat = 0
    @State private var startFinishOffset: CGFloat = 0
    @State private var barierXOffset: CGFloat = 0
    @State private var bariersArray = Arrays.batiersArray
    var body: some View {
        ZStack {
            Background(backgroundNumber: 2)
            
            HStack(alignment: .top) {
                Image("pauseButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.14)
                    .onTapGesture {
                        showPause.toggle()
                    }
                Spacer()
                ZStack {
                    Image("loadingBarBack")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.5)
                    
                    Image("loadingBarFront")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.495)
                        .offset(x: -screenWidth*0.5*runProgress)
                        .mask(
                            Image("loadingBarFront")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.495)                                )
                }
                .padding(.top, screenHeight*0.02)
                //                Spacer()
                VStack(spacing: 0) {
                    ZStack {
                        Image("staminaLineBack")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenHeight*0.12)
                        Image("staminaLineFront")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenHeight*0.027)
                            .offset(y: screenHeight*0.005)
                            .offset(x: -screenWidth*0.2*stamina)
                            .mask(
                                Image("staminaLineFront")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.027)
                                    .offset(y: screenHeight*0.005)
                            )
                    }
                    
                    Text("STAMINA")
                        .font(Font.custom("Chewy-Regular", size: screenWidth*0.03))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2)
                        .shadow(color: .black, radius: 2)
                    
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(screenHeight*0.07)
            Image("raceTrack")
            //                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*1, height: screenHeight*0.5)
                .offset(x: trackOffset*screenWidth, y: screenHeight*0.2)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            // Определяем направление свайпа
                            if value.translation.height < 0 && horseVerticalOffset > -screenHeight*0.2 {
                                // Свайп вверх
                                withAnimation {
                                    horseVerticalOffset -= screenHeight*0.2
                                }
                            } else  if value.translation.height > 0 && horseVerticalOffset < screenHeight*0.2{
                                // Свайп вниз
                                withAnimation {
                                    horseVerticalOffset += screenHeight*0.2
                                }
                            }
                        }
                )
            Image("startLine")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.6)
                .offset(x:-screenWidth*0.37 + startFinishOffset ,y: screenHeight*0.24)
            Image("finishLine")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.6)
                .offset(x:screenWidth*2.6 + startFinishOffset,y: screenHeight*0.24)
//            Image("barier1")
//                .resizable()
//                .scaledToFit()
//                .frame(height: screenHeight*0.1)
//                .offset(x: barierXOffset, y: screenHeight*0.2)
            ZStack {
                ForEach(0..<bariersArray.count, id: \.self) { item in
                    if bariersArray[item].haveBarier {
                        Image(bariersArray[item].name)
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenHeight*0.1)
                            .offset(x: barierXOffset, y: bariersArray[item].yOffset)
                    }
                }
            }
            //            Horse(startRun: startRun, boostSpeed: boostOn, jump: horseJump)
            //                .offset(x: -screenWidth*0.4, y: screenHeight*0)
            Horse(startRun: $startRun, boostSpeed: boostOn, jump: horseJump)
                .offset(x: -screenWidth*0.4 + horseBoostOffset, y: screenHeight*0.2+horseVerticalOffset)
            //            Horse(startRun: startRun, boostSpeed: boostOn, jump: horseJump)
            //                .offset(x: -screenWidth*0.4, y: screenHeight*0.4)
            HStack {
                Image("boostButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.15)
                    .onTapGesture {
                        boostOn.toggle()
                        if stamina <= 0.8 {
                            withAnimation(Animation.easeIn(duration: 1)) {
                                horseBoostOffset += screenWidth*0.1
                            }
                            stamina += 0.2
                        }
                    }
                Image("jumpButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.15)
                    .onTapGesture {
                        if stamina <= 0.8 {
                            horseJump = true
                            stamina += 0.2
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                horseJump = false
                            }
                        }
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding()
            .padding(.trailing, screenWidth*0.05)
           
            if showPause {
                Pause(showPause: $showPause)
            }
            if youLose {
                YouLose(youLose: $youLose)
            }
            if youWin {
                YouWin(youWin: $youWin)
            }
        }
        
        .onChange(of: startRun) { _ in
            if startRun {
                trackAnimation()
            } else {
//                stopTrackAnimation()
                stopFinishLineAnimation()
            }
        }
        .onChange(of: startFinishOffset) { _ in
            if startFinishOffset <= -screenWidth*3 {
                stopTrackAnimation()
                stopFinishLineAnimation()
            }
        }
        
        .onChange(of: barierXOffset) { _ in
            for i in 0..<bariersArray.count {
                if barierXOffset <= -screenWidth*0.4 + 50 && !horseJump && barierXOffset >= -screenWidth*0.4 - 50 && horseVerticalOffset + screenHeight*0.2 == bariersArray[i].yOffset && bariersArray[i].haveBarier{
                    //                stopTrackAnimation()
                    //                stopFinishLineAnimation()
                    startRun = false
                }
            }
        }
        
        .onAppear {
            createBariers()
            startRun = true
            barierXOffset = screenWidth*0.6
            trackAnimation()
            startFinishLineAnimation()
        }
        
    }
    
    func objectsMoving() {
        
    }
    
    func createBariers() {
        var offsetArray = [screenHeight*0.2, 0, screenHeight*0.4]
        var bariersNameArray = ["barier1", "barier2", "barier3"]
        offsetArray.shuffle()
        bariersNameArray.shuffle()
        for i in 0..<bariersArray.count {
            bariersArray[i].haveBarier = Bool.random()
            bariersArray[i].name = bariersNameArray[i]
            bariersArray[i].yOffset = offsetArray[i]
        }
    }
    
    func finishedAnimation() {
        withAnimation(Animation.easeInOut(duration: 2)) {
            horseBoostOffset = screenWidth
        }
    }
    
    func startFinishLineAnimation() {
        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            if startFinishOffset > -screenWidth*2.9 {
                withAnimation(Animation.linear(duration: 0.5)) {
                    if runProgress > 0 {
                        runProgress -= 0.02
                    }
                    startFinishOffset -= screenWidth*0.05
                    barierXOffset -= screenWidth*0.05
                }
            } else {
                stopTrackAnimation()
                stopFinishLineAnimation()
                startRun = false
                finishedAnimation()
            }
        }
    }
    
    func stopFinishLineAnimation() {
        progressTimer?.invalidate()
        progressTimer = nil
    }
    
    func trackAnimation() {
        trackTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            if startRun {
                trackOffset = 0.049
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    trackOffset = 0
                }
            }
        }
    }
    
    func stopTrackAnimation() {
        trackTimer?.invalidate()
        trackTimer = nil
    }
    
}

#Preview {
    Game()
}
