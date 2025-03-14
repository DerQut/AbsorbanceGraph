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
                .navigationSplitViewColumnWidth(200)
                //.ignoresSafeArea()
        } detail: {
            DetailView()
                .ignoresSafeArea()
        }
        .navigationTitle("Absorbance Graph")
    }
}

#Preview {
    ContentView()
        .environmentObject(GlobalData())
}
