//
//  timerApp.swift
//  timer
//
//  Created by Samuel Luggeri on 08/02/25.
//

import SwiftUI

@main
struct timerApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
            
    #if os(macOS)
    Settings {
        SettingsView()
    }
    #endif
        
    }
}
