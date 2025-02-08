//
//  CountDownView.swift
//  timer
//
//  Created by Samuel Luggeri on 08/02/25.
//

import SwiftUI

struct CountdownView: View {
    
    @State private var remainingTime: Int
    @State private var countdownTimer: Timer?
    
    init(duration: Int) {
        self.remainingTime = duration
    }
    
    var body: some View {
        GeometryReader { geometry in
            let minutes: Int = abs(remainingTime/60);
            let seconds: Int = abs(remainingTime - (minutes*60));
            
            let textColor: Color = {
                if remainingTime < 0 {
                    return .red
                } else if remainingTime < 30 {
                    return .orange
                } else {
                    return .white
                }
            }()
            
            // Set fontSize based on window(Screen) dimensions
            let fontSize = min(geometry.size.width, geometry.size.height) * 0.4
            
            VStack {
                if remainingTime>0{
                    Text("Tempo rimanente")
                        .font(.system(size: fontSize*0.3))
                }else{
                    Text("Tempo scaduto")
                        .font(.system(size: fontSize*0.3))
                }
                
                Divider()
                    .background(Color.gray)
                    .padding(.bottom, 10)
                
                Text("\(minutes):\(seconds)")
                    .font(.system(size: fontSize))
                    .fontWeight(.bold)
                    .foregroundColor(textColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .multilineTextAlignment(.center)
            }.onAppear(){
                startCountdown()
            }
            .onDisappear {
                countdownTimer?.invalidate()
            }
        }
    }
    
    func startCountdown() {
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.remainingTime -= 1
        }
    }
    
}
#Preview {
    CountdownView(duration: 10)
}
