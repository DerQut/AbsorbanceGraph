//
//  TimeTableView.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 16/03/2025.
//

import Foundation
import SwiftUI

struct TimeTableView: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    var body: some View {
        VStack {
            Text("Time, t [\(globalData.timeUnit)]")
            Divider()
                .frame(width: 125)
            ForEach (globalData.tableData.indices) { index in
                TextField("", text: $globalData.tableData[index].timeStep)
                    .textFieldStyle(.roundedBorder)
                    .colorScheme(.light)
                    .frame(width: 125)
                    .onChange(of: globalData.tableData[index].timeStep) {
                        let temp = globalData.tableData[index].timeStep
                        if !temp.isInteger && !temp.isDouble && !temp.isEmpty {
                            globalData.tableData[index].timeStep = temp.filter {$0.isNumber}
                        }
                    }
            }
        }
    }
}
