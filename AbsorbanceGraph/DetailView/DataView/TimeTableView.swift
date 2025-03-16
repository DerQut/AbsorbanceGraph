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
            Text("Time, t [min]")
            Divider()
                .frame(width: 100)
            ForEach (globalData.inputData.indices) { index in
                TextField("", text: $globalData.inputData[index].timeStep)
                    .frame(width: 100)
                    .onChange(of: globalData.inputData[index].timeStep) {
                        let temp = globalData.inputData[index].timeStep
                        if !temp.isInteger && !temp.isDouble && !temp.isEmpty {
                            globalData.inputData[index].timeStep = temp.filter {$0.isNumber}
                        }
                    }
            }
        }
    }
}
