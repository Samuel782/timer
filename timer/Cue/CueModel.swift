//
//  CueModel.swift
//  timer
//
//  Created by Samuel Luggeri on 02/03/25.
//

import SwiftUI

class CueModel: Identifiable, ObservableObject {
    var id = UUID()
    @Published var timeRemainingCue: Int
    @Published var isPlaying: Bool
    @Published var name: String
    
    init(duration: Int, name: String) {
        self.name = name
        self.isPlaying = false
        self.timeRemainingCue = duration
    }

    func start() {
        objectWillChange.send()
        isPlaying = true
    }
    
    func updateDuration(newTime: Int) {
        timeRemainingCue = newTime
        objectWillChange.send()
    }
    
    func updateList(){
        objectWillChange.send()
    }
}

