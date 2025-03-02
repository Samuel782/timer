//
//  CueModel.swift
//  timer
//
//  Created by Samuel Luggeri on 02/03/25.
//

import SwiftUI

class CueModel: ObservableObject, Identifiable {
    var id = UUID()
    @Published var timeRemainingCue: Int
    @Published var isPlaying: Bool
    @Published var name: String
    @Published var minutiText: String
    @Published var secondiText: String
    
    private var timer: Timer?
    
    init(duration: Int, name: String) {
        self.name = name
        self.isPlaying = false
        self.timeRemainingCue = duration
        self.minutiText = String(format: "%02d", duration / 60)
        self.secondiText = String(format: "%02d", duration % 60)
    }

    func start() {
        isPlaying = true
    }
    func updateDuration() {
        let minutes = timeRemainingCue / 60
        let seconds = timeRemainingCue % 60
        minutiText = String(format: "%02d", minutes)
        secondiText = String(format: "%02d", seconds)
    }
}
