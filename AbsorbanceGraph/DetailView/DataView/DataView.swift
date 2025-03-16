//
//  DataView.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 14/03/2025.
//

import SwiftUI

struct DataView: View {
    @EnvironmentObject var globalData: GlobalData
    
    #if os(iOS)
    let frameWidth: CGFloat = 200
    #else
    let frameWidth: CGFloat = 150
    #endif
    
    var body: some View {
        ScrollView {
            HStack {
                TimeTableView()
                AbsorbanceTableView(frameWidth: frameWidth)
                ConcentrationTableView(frameWidth: frameWidth)
                DegradationTableView(frameWidth: frameWidth)
            }
        }
    }
}
