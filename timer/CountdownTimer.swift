//
//  CountdownTimer.swift
//  timer
//
//  Created by Samuel Luggeri on 08/02/25.
//

import SwiftUI

class CountdownTimer: ObservableObject {
    @Published var remainingTime: Int
    
    private var countdownTimer: Timer?
    
    init(initialTime: Int = 0) {
        self.remainingTime = initialTime
    }
    
    func startCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.remainingTime -= 1
        }
    }
    
    func setTimer(duration: Int) {
        self.remainingTime = duration
        startCountdown()
    }
    
    func stopCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = nil
    }
}
