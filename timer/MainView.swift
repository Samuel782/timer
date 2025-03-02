import SwiftUI

struct MainView: View {
    @State private var selectedScreenIndex = UserDefaults.standard.integer(forKey: "selectedScreen")
    @State private var settingsWindow: NSWindow?
    @State private var countdownString: String = ""
    
    @StateObject private var countdownTimer = CountdownTimer()
    
    
    let screens = NSScreen.screens
    
    @State private var cueList: [CueModel] = [
        CueModel(duration: 10, name: "Parte 1"),
        CueModel(duration: 10, name: "Parte 2")
    ]
    
    var body: some View {
        VStack {
            Text("Finestra di Controllo")
                .font(.title)
            
            Button("Avvia Cue") {
                let cuetest = cueList[0]
                    startCue(cuetest)
            }
            .padding()
            
            NavigationView {
                List(cueList) { cue in
                    HStack {
                        Text(cue.name)
                            .font(.headline)
                            .padding(.vertical, 5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Text("\(cue.timeRemainingCue) sec")
                            .font(.headline)
                            .padding(.vertical, 5)
                            .frame(alignment: .trailing)
                    }
                    .padding(4)
                    .background(cue.isPlaying ? Color.accentColor : Color.clear)
                    .cornerRadius(5)
                    .onTapGesture{
                        openCuewWindow(cue: cue)
                    }
                }
                .navigationTitle("Lista Cue")
            }
            .cornerRadius(5)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: addCue) {
                        Label("Aggiungi Cue", systemImage: "plus")
                    }
                }
            }
            
            TextField("CountDown", text: $countdownString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                Button("Avvia Timer") {
                    let val: Int = Int(countdownString) ?? 0
                    countdownTimer.setTimer(duration: val)
                }
                .padding()
                
                Button("Pausa Timer") {
                    countdownTimer.stopCountdown()
                }
                .padding()
                
                Button("Reset Timer") {
                    countdownTimer.setTimer(duration: 0)
                    countdownTimer.stopCountdown()
                }
                .padding()
            }
            
            CountdownView(countdownTimer: countdownTimer)
            
            Button("Apri Schermo Intero") {
                if let selectedScreen = getSelectedScreen() {
                    openFullScreenWindow(on: selectedScreen)
                }
            }
            .padding()
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
    
    func openCuewWindow(cue: CueModel) {
        let newWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 300, height: 200),
            styleMask: [.titled, .closable, .resizable],
            backing: .buffered,
            defer: false
        )
        newWindow.center()
        newWindow.setFrameAutosaveName("New Cue Window")
        newWindow.isReleasedWhenClosed = false
        newWindow.contentView = NSHostingView(rootView: CueView(cue: cue))
        newWindow.makeKeyAndOrderFront(nil)
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
        fullScreenWindow.contentView = NSHostingView(rootView: FullScreenView(countdownView: CountdownView(countdownTimer: countdownTimer)))
        fullScreenWindow.level = .mainMenu + 1
        fullScreenWindow.makeKeyAndOrderFront(nil)
        fullScreenWindow.toggleFullScreen(nil)
    }
    
    func addCue() {
        let newCue = CueModel(duration: 0, name: "Nuova Parte")
        cueList.append(newCue)
    }
    func startCue(_ cue: CueModel) {
        if let index = cueList.firstIndex(where: { $0.id == cue.id }) {
            cueList[index].start()
        }
    }
}

extension NSNotification.Name {
    static let didChangeSelectedScreen = NSNotification.Name("didChangeSelectedScreen")
}

#Preview {
    MainView()
}
