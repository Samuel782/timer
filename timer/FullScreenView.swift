//
//  FullScreenView.swift
//  timer
//
//  Created by Samuel Luggeri on 08/02/25.
//

import SwiftUI

struct FullScreenView: View {
    var body: some View {
        CountdownView(duration: 60) // durata del countdown
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

