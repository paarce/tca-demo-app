//
//  TCA_Project1App.swift
//  TCA-Project1
//
//  Created by Augusto Cordero Perez on 7/3/23.
//

import SwiftUI

@main
struct TCA_Project1App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(initialValue: AppState()))
        }
    }
}
