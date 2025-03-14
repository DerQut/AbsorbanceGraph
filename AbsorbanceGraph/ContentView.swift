//
//  ContentView.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 14/03/2025.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    var body: some View {
        NavigationSplitView {
            SideBarView()
                .ignoresSafeArea()
        } detail: {
            DetailView()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
