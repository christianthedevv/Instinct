//
//  SpinningSlot.swift
//  Instinct
//
//  Created by Christian Rodriguez on 10/26/23.
//

import SwiftUI

struct SpinningSlot: View {
    @State private var timesTable = 1
    @State private var randomPickedNumber = 1
    
    var body: some View {
        VStack {
            Form {
                Section {
                    Picker("Times Table", selection: $timesTable) {
                        ForEach(0..<13) {
                            Text($0, format: .number)
                            //.animation(.interpolatingSpring(stiffness: 170, damping: 2.0))
                        }
                    }
                    .pickerStyle(.wheel)
                    Button("Spin") {
                        withAnimation(.interactiveSpring(response: 10, dampingFraction: 0.5, blendDuration: 1.0)) {
                            timesTable = Int.random(in: 1..<13)
                            
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SpinningSlot()
}
