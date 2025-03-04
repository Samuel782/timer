//
//  CountdownTimer.swift
//  timer
//
//  Created by Samuel Luggeri on 08/02/25.
//

import SwiftUI

class CountdownTimer: ObservableObject {
    @Published var cue: CueModel
    
    private var countdownTimer: Timer?
    
    init(cue: CueModel) {
        self.cue = cue
    }
    
    func startCountdown() {
        cue.isPlaying = true
        countdownTimer?.invalidate()
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.cue.timeRemainingCue -= 1
        }
    }
    
    func nextCue(newCue: CueModel){
        self.cue = newCue
    }
    
    func stopCountdown() {
        cue.isPlaying = false
        countdownTimer?.invalidate()
        countdownTimer = nil
    }
}
