//
//  LaunchScreenManager.swift
//  Instinct
//
//  Created by Christian Rodriguez on 10/24/23.
//

import Foundation

final class LaunchScreenStateManager: ObservableObject {

@MainActor @Published private(set) var state: LaunchScreenStep = .firstStep

    @MainActor func dismiss() {
        Task {
            state = .secondStep

            try? await Task.sleep(for: Duration.seconds(15))

            self.state = .finished
        }
    }
}

enum LaunchScreenStep {
    case firstStep
    case secondStep
    case finished
}

