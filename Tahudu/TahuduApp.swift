//
//  TahuduApp.swift
//  Tahudu
//

import SwiftUI

@main
struct TahuduApp: App {
    // Here I am doing the initialization of the container.
    private let container = AppContainer()

    var body: some Scene {
        WindowGroup {
            TahuduTabView(
                searchViewModel: container.makeSearchViewModel()
            )
        }
    }
}
