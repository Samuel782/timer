//
//  CueRow.swift
//  timer
//
//  Created by Samuel Luggeri on 03/03/25.
//
import SwiftUI

struct CueRow: View {
    @ObservedObject var cue: CueModel

    var body: some View {
        HStack {
            Text(cue.name)
                .font(.headline)
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Text("\(cue.timeRemainingCue)")
                .font(.headline)
                .padding(.vertical, 5)
                .frame(alignment: .trailing)
        }
        .padding(4)
        .background(cue.isPlaying ? Color.accentColor : Color.clear)
        .cornerRadius(5)
        .onTapGesture {
            openCuewWindow(cue: cue)
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

    
}
