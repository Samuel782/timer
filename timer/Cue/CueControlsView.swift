//
//  CueControls.swift
//  timer
//
//  Created by Samuel Luggeri on 04/03/25.
//
import SwiftUI

struct CueControlsView: View {
    @Binding var cuePosition: Int
    @ObservedObject var cueSequence: CueSequence
    @ObservedObject var countdownTimer: CountdownTimer

    func updateCue(forward: Bool) {
        // Verifica se la posizione è valida
        if (forward && cuePosition < cueSequence.cueList.count && cueSequence.cueList[cuePosition].name != "END") ||
           (!forward && cuePosition > 0) {

            // Ferma il cue corrente
            cueSequence.cueList[cuePosition].isPlaying = false

            // Avanza o torna indietro nella sequenza
            cuePosition += forward ? 1 : -1

            // Verifica la nuova posizione
            if cuePosition >= 0 && cuePosition < cueSequence.cueList.count {
                // Attiva il nuovo cue
                cueSequence.cueList[cuePosition].isPlaying = true
                // Avvia il countdown per il nuovo cue
                countdownTimer.nextCue(newCue: cueSequence.cueList[cuePosition])
            }
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
                // Non riprodurre il placeholder
                if countdownTimer.cue.name != "UGxhY2VIb2xkZXI=" && countdownTimer.cue.timeRemainingCue != 0 {
                    countdownTimer.startCountdown()
                }
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
