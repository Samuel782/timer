import SwiftUI

struct MainView: View {
    @State private var selectedScreenIndex = UserDefaults.standard.integer(
        forKey: "selectedScreen")
    @State private var settingsWindow: NSWindow?
    @State private var countdownString: String = ""

    @StateObject private var cueSequence = CueSequence()

    @StateObject private var countdownTimer = CountdownTimer()

    let screens = NSScreen.screens

    var body: some View {

        HStack {
            List {
                ForEach(cueSequence.cueList) { cue in
                    CueRow(cue: cue)
                }
            }.cornerRadius(5)

            Divider()

            VStack {
                let s = countdownTimer.getPlayingCueName()
                Text(s)

                if countdownTimer.cue != nil {
                    CountdownView(cue: countdownTimer.cue!)
                }

                CueControlsView(
                    cuePosition: 0, cueSequence: cueSequence,
                    countdownTimer: countdownTimer)

                Button("Apri Schermo Intero") {
                    if let selectedScreen = getSelectedScreen() {
                        openFullScreenWindow(on: selectedScreen)
                    }
                }
                .padding()
            }

        }
        .padding()
        .onAppear {
            selectedScreenIndex = UserDefaults.standard.integer(
                forKey: "selectedScreen")
            NotificationCenter.default.addObserver(
                forName: .didChangeSelectedScreen, object: nil, queue: .main
            ) { _ in
                selectedScreenIndex = UserDefaults.standard.integer(
                    forKey: "selectedScreen")
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(
                self, name: .didChangeSelectedScreen, object: nil)
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
        guard selectedScreenIndex >= 0 && selectedScreenIndex < screens.count
        else {
            return nil
        }
        return screens[selectedScreenIndex]
    }

    func openFullScreenWindow(on screen: NSScreen) {
        if countdownTimer.cue != nil {
            let fullScreenWindow = NSWindow(
                contentRect: screen.frame,
                styleMask: [.borderless],
                backing: .buffered,
                defer: false
            )
            fullScreenWindow.isReleasedWhenClosed = false
            fullScreenWindow.contentView = NSHostingView(
                rootView: FullScreenView(
                    countdownView: CountdownView(cue: countdownTimer.cue!)))
            fullScreenWindow.level = .mainMenu + 1
            fullScreenWindow.makeKeyAndOrderFront(nil)
            fullScreenWindow.toggleFullScreen(nil)
        }
    }

    func addCue() {
        let newCue = CueModel(duration: 0, name: "Nuova Parte")
        cueSequence.cueList.append(newCue)
    }
    func startCue(_ cue: CueModel) {
        if let index = cueSequence.cueList.firstIndex(where: { $0.id == cue.id }
        ) {
            cueSequence.cueList[index].start()
        }
    }
}

extension NSNotification.Name {
    static let didChangeSelectedScreen = NSNotification.Name(
        "didChangeSelectedScreen")
}

#Preview {
    MainView()
}
