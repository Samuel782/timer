//
//  SettingView.swift
//  timer
//
//  Created by Samuel Luggeri on 08/02/25.
//
import SwiftUI

class ScreenManager: ObservableObject {
    @Published var screens: [NSScreen] = NSScreen.screens
    @Published var selectedScreenIndex = UserDefaults.standard.integer(forKey: "selectedScreen")
}

struct SettingsView: View {
    @ObservedObject var screenManager = ScreenManager()
    
    var body: some View {
        VStack {
            Text("Seleziona il monitor per la finestra a schermo intero")
                .font(.headline)
                .padding()
            
            Picker("Seleziona Monitor", selection: $screenManager.selectedScreenIndex) {
                ForEach(0..<screenManager.screens.count, id: \.self) { index in
                    Text("Monitor \(index + 1): \(screenManager.screens[index].localizedName)").tag(index)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            Button("Chiudi") {
                NSApplication.shared.keyWindow?.close() // Chiude la finestra delle impostazioni
            }
            .padding()
            
            // Salva la selezione del monitor ogni volta che cambia
            .onChange(of: screenManager.selectedScreenIndex) { oldValue, newValue in
                UserDefaults.standard.set(newValue, forKey: "selectedScreen")
                UserDefaults.standard.synchronize() // Ensure the UserDefaults are synchronized
                NotificationCenter.default.post(name: .didChangeSelectedScreen, object: nil)
            }
        }
        .frame(width: 300, height: 200)
        .padding()
    }
    
    func getTimerDisplay() -> NSScreen? {
        guard screenManager.screens.count > screenManager.selectedScreenIndex else { return nil }
        return screenManager.screens[screenManager.selectedScreenIndex]
    }
}

#Preview {
    SettingsView()
}
