//
//  appSaverApp.swift
//  appSaver
//
//  Created by duverney muriel on 13/10/23.
//

import SwiftUI
import SwiftData
@main
struct appSaverApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Saving.self)
        }
    }
}
