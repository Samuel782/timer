//
//  CountDownView.swift
//  timer
//
//  Created by Samuel Luggeri on 08/02/25.
//
import SwiftUI
struct CountdownView: View {
    @ObservedObject var cue: CueModel
    
    var body: some View {
        GeometryReader { geometry in
            let minutes = abs(cue.timeRemainingCue) / 60
            let seconds = abs(cue.timeRemainingCue) % 60
            
            let textColor: Color = {
                if cue.timeRemainingCue < 0 {
                    return .red
                } else if cue.timeRemainingCue < 30 {
                    return .orange
                } else {
                    return .white
                }
            }()
            
            let fontSize = min(geometry.size.width, geometry.size.height) * 0.4
            
            VStack {
                Text(cue.timeRemainingCue > 0 ? "Tempo rimanente" : "Tempo scaduto")
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

        }
    }
}
