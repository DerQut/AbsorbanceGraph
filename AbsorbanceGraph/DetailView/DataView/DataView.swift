//
//  DataView.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 14/03/2025.
//

import SwiftUI

struct DataView: View {
    @EnvironmentObject var globalData: GlobalData
    
    var body: some View {
        ScrollView {
            HStack {
                TimeTableView()
                AbsorbanceTableView()
                ConcentrationTableView()
                DegradationTableView()
            }
        }
    }
}
