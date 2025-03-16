//
//  ContentView.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 14/03/2025.
//

import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    #if os(iOS)
    var columnWidth: CGFloat = 400
    #else
    var columnWidth: CGFloat = 270
    #endif
    
    var body: some View {
        NavigationSplitView {
            SideBarView()
                .navigationSplitViewColumnWidth(columnWidth)
            
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
