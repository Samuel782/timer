//
//  MainView.swift
//  timer
//
//  Created by Samuel Luggeri on 08/02/25.
//
import SwiftUI

struct MainView: View {
    @State private var selectedScreenIndex = UserDefaults.standard.integer(forKey: "selectedScreen")
    @State private var settingsWindow: NSWindow?
    
    let screens = NSScreen.screens
    
    var body: some View {
        VStack {
            Text("Finestra di Controllo")
                .font(.title)
            
            Button("Apri Impostazioni") {
                openSettingsWindow()
            }
            .padding()
            
            Button("Apri Schermo Intero") {
                if let selectedScreen = getSelectedScreen() {
                    openFullScreenWindow(on: selectedScreen)
                }
            }
        }
        .padding()
        .onAppear {
            selectedScreenIndex = UserDefaults.standard.integer(forKey: "selectedScreen")
            NotificationCenter.default.addObserver(forName: .didChangeSelectedScreen, object: nil, queue: .main) { _ in
                selectedScreenIndex = UserDefaults.standard.integer(forKey: "selectedScreen")
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self, name: .didChangeSelectedScreen, object: nil)
        }
    }
    
    func openSettingsWindow() {
        if settingsWindow == nil {
            let settingsView = SettingsView()
            let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 300, height: 200),
                styleMask: [.titled, .closable, .resizable],
                backing: .buffered,
                defer: false
            )
            window.center()
            window.setFrameAutosaveName("Settings Window")
            window.isReleasedWhenClosed = false
            window.contentView = NSHostingView(rootView: settingsView)
            
            settingsWindow = window
        }
        settingsWindow?.makeKeyAndOrderFront(nil)
    }
    
    func getSelectedScreen() -> NSScreen? {
        let screens = NSScreen.screens
        guard selectedScreenIndex >= 0 && selectedScreenIndex < screens.count else {
            return nil
        }
        return screens[selectedScreenIndex]
    }
    
    func openFullScreenWindow(on screen: NSScreen) {
        let fullScreenWindow = NSWindow(
            contentRect: screen.frame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        fullScreenWindow.isReleasedWhenClosed = false
        fullScreenWindow.contentView = NSHostingView(rootView: FullScreenView())
        fullScreenWindow.level = .mainMenu + 1
        fullScreenWindow.makeKeyAndOrderFront(nil)
        fullScreenWindow.toggleFullScreen(nil)
    }
    
}

extension NSNotification.Name {
    static let didChangeSelectedScreen = NSNotification.Name("didChangeSelectedScreen")
}
