//
//  CueControls.swift
//  timer
//
//  Created by Samuel Luggeri on 04/03/25.
//
import SwiftUI

struct CueControlsView: View {
    @State var cuePosition: Int = 0
    @ObservedObject var cueSequence: CueSequence
    @ObservedObject var countdownTimer: CountdownTimer

    func updateCue(forward: Bool) {
        var newPos: Int = cuePosition + (forward ? 1 : -1)

        if newPos >= 0 && newPos < cueSequence.cueList.count {
            cueSequence.cueList[cuePosition].isPlaying = false

            cuePosition = newPos

            cueSequence.cueList[cuePosition].isPlaying = true
            countdownTimer.nextCue(newCue: cueSequence.cueList[cuePosition])
        }
    }

    var body: some View {
        HStack {
            // Bottone backward
            Button {
                updateCue(forward: false)
            } label: {
                Image(systemName: "backward.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .padding(10)
            }
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.secondary.opacity(0.8))
            )
            .foregroundColor(.primary)
            .shadow(radius: 5)
            .padding()

            // Bottone play
            Button {
                countdownTimer.startCountdown()
            } label: {
                Image(systemName: "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .padding(10)
            }
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.accentColor.opacity(0.8))
            )
            .foregroundColor(.primary)
            .shadow(radius: 5)
            .padding()

            // Bottone forward
            Button {
                updateCue(forward: true)
            } label: {
                Image(systemName: "forward.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .padding(10)
            }
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.secondary.opacity(0.8))
            )
            .foregroundColor(.primary)
            .shadow(radius: 5)
            .padding()
        }
    }
}
