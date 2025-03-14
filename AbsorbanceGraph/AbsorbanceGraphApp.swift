//
//  AbsorbanceGraphApp.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 14/03/2025.
//

import SwiftUI

@main
struct AbsorbanceGraphApp: App {
    var globalData: GlobalData = GlobalData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(globalData)
        }
    }
}
