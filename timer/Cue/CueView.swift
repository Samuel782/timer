import SwiftUI

struct CueView: View {
    @ObservedObject var cue: CueModel
    
    @State private var minuteText: String
    @State private var secondsText: String

    init(cue: CueModel) {
        self.cue = cue
        minuteText = String(cue.timeRemainingCue / 60)
        secondsText = String(cue.timeRemainingCue % 60)
    }

    var body: some View {
        VStack {
            Text("Imposta tempo di: " + cue.name)
                .font(.headline)
                .padding()
            
            HStack {
                TextField("Minuti", text: $minuteText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: minuteText) { _, newValue in
                        let filtered = newValue.filter { $0.isNumber }
                        minuteText = filtered
                    }
                    .onSubmit {
                        refreshTime()
                    }
                
                TextField("Secondi", text: $secondsText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: secondsText) { _, newValue in
                        let filtered = newValue.filter { $0.isNumber }
                        if let valore = Int(filtered), valore >= 60 {
                            let extraMinutes = valore / 60
                            let remainingSeconds = valore % 60
                            minuteText = String((Int(minuteText) ?? 0) + extraMinutes)
                            secondsText = String(remainingSeconds)
                        } else {
                            secondsText = filtered
                        }
                    }
                    .onSubmit {
                        refreshTime()
                    }
            }
            .padding()
        }
    }
    func refreshTime() {
        cue.timeRemainingCue = (Int(minuteText) ?? 0) + (Int(secondsText) ?? 0)
        cue.updateList()
    }
 
}
