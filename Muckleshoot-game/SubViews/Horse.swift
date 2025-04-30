//
//  Horse.swift
//  Muckleshoot-game
//
//  Created by Алкександр Степанов on 22.04.2025.
//

import SwiftUI

struct Horse: View {
    @State private var timer: Timer?
    @Binding var horseArray: [String]
   @Binding var startRun: Bool
    @Binding var runAlreadyStart: Bool
    var boostSpeed = false
    var jump = false
    @State private var horseAngleDegrees: CGFloat = 0
    @State private var horseOffset: CGFloat = 0
    @State private var horseName = "horse11"
    @State private var horseIndex = 0
    @State var horseSpeed = 0.15
    var body: some View {
        ZStack {
           Image(horseName)
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.1)
                .rotationEffect(Angle(degrees: horseAngleDegrees))
                .offset(y: screenHeight*horseOffset)
                .onTapGesture {
//                    horseJump()
                }
        }
        
        .onAppear {
            horseName = horseArray[0]
        }
        
        .onChange(of: startRun) { _ in
            if startRun {
                horseRun()
            } else {
                stopHorseRun()
            }
        }
        
        .onChange(of: boostSpeed) { _ in
            if boostSpeed {
                changeHorseSpeed(to: 0.1)
            }
        }
        
        .onChange(of: jump) { _ in
            if !jump {
                horseJump()
            }
        }
        
    }
    
    func horseJump() {
        stopHorseRun()
        horseName = horseArray[2]
        withAnimation(Animation.easeInOut(duration: 0.4)) {
            horseOffset = -0.05
            horseAngleDegrees = -5
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            horseName = horseArray[1]
            withAnimation(Animation.easeInOut(duration: 0.4)) {
                horseAngleDegrees = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            horseName = horseArray[2]
            withAnimation(Animation.easeInOut(duration: 0.4)) {
                horseOffset = 0
                horseAngleDegrees = 5
                horseRun()
            }
        }
    }
    
    func changeHorseSpeed(to: Double) {
        stopHorseRun()
        horseSpeed = to
        horseRun()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            stopHorseRun()
            horseSpeed = 0.15
            horseRun()
        }
    }
    
    func horseRun() {
        timer = Timer.scheduledTimer(withTimeInterval: horseSpeed, repeats: true) { _ in
            if horseIndex < 2 {
                horseIndex += 1
            } else {
                horseIndex = 0
            }
            horseName = horseArray[horseIndex]
        }
    }
    
    func stopHorseRun() {
            timer?.invalidate()
            timer = nil
        horseName = horseArray[0]
        }
    
}

#Preview {
    Horse(horseArray: .constant(["horse21", "horse23", "horse22"]), startRun: .constant(false), runAlreadyStart: .constant(false))
}
