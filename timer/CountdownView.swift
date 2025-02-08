//
//  CountDownView.swift
//  timer
//
//  Created by Samuel Luggeri on 08/02/25.
//
import SwiftUI
struct CountdownView: View {
    @ObservedObject var countdownTimer: CountdownTimer
    
    var body: some View {
        GeometryReader { geometry in
            let minutes = abs(countdownTimer.remainingTime) / 60
            let seconds = abs(countdownTimer.remainingTime) % 60
            
            let textColor: Color = {
                if countdownTimer.remainingTime < 0 {
                    return .red
                } else if countdownTimer.remainingTime < 30 {
                    return .orange
                } else {
                    return .white
                }
            }()
            
            let fontSize = min(geometry.size.width, geometry.size.height) * 0.4
            
            VStack {
                Text(countdownTimer.remainingTime > 0 ? "Tempo rimanente" : "Tempo scaduto")
                    .font(.system(size: fontSize * 0.3))
                
                Divider()
                    .background(Color.gray)
                    .padding(.bottom, 10)
                
                Text(String(format: "%02d:%02d", minutes, seconds))
                    .font(.system(size: fontSize))
                    .fontWeight(.bold)
                    .foregroundColor(textColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .multilineTextAlignment(.center)
            }
            .onDisappear {
                countdownTimer.stopCountdown()
            }
        }
    }
}
