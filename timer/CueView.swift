import SwiftUI
import SwiftUI

struct CueView: View {
    @ObservedObject var cue: CueModel
    
    var body: some View {
        VStack {
            Text("Imposta tempo di: " + cue.name)
                .font(.headline)
                .padding()
            
            HStack {
                TextField("Minuti", text: $cue.minutiText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: cue.minutiText) { oldValue, newValue in
                        cue.minutiText = newValue.filter { $0.isNumber }
                    }
                
                TextField("Secondi", text: $cue.secondiText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: cue.secondiText) { oldValue, newValue in
                        let filtered = newValue.filter { $0.isNumber }
                        if let valore = Int(filtered), valore >= 60 {
                            let extraMinutes = valore / 60
                            let remainingSeconds = valore % 60
                            let currentMinutes = Int(cue.minutiText) ?? 0
                            cue.minutiText = String(currentMinutes + extraMinutes)
                            cue.secondiText = String(remainingSeconds)
                        } else {
                            cue.secondiText = filtered
                        }
                    }
            }
            .padding()
        }
    }
}
