//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by Jeremy Kim on 5/9/25.
//

import SwiftUI

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}
