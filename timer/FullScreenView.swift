//
//  FullScreenView.swift
//  timer
//
//  Created by Samuel Luggeri on 08/02/25.
//

import SwiftUI

struct FullScreenView: View {
    var countdownView: CountdownView
    
    var body: some View {
        countdownView
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .onAppear {
                // Azioni da eseguire quando la vista appare
            }
    }
    
}
