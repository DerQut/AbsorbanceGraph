//
//  DetailView.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 14/03/2025.
//

import SwiftUI

struct DetailView: View {
    
    @State var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Data", systemImage: "tablecells", value: 0) {
                DataView()
            }


            Tab("Graphs", systemImage: "chart.dots.scatter", value: 1) {
                GraphsView()
            }
        }
    }
}
