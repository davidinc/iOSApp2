//
//  iOSApp2App.swift
//  iOSApp2
//
//  Created by Dawit Chernet on 2026-06-05.
//

import SwiftUI
import SwiftData

@main
struct iOSApp2App: App {
    var body: some Scene {
        WindowGroup {
            HuntListView()
        }
        .modelContainer(for: HuntItem.self)
    }
}
