//
//  CueSequence.swift
//  timer
//
//  Created by Samuel Luggeri on 03/03/25.
//
import SwiftUI

class CueSequence: ObservableObject {
    @Published var cueList: [CueModel] = [
        CueModel(duration: 10, name: "Parte 1"),
        CueModel(duration: 30, name: "Parte 2")
    ]
}
