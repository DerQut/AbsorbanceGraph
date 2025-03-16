//
//  DegradationTableView.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 16/03/2025.
//

import Foundation
import SwiftUI


struct DegradationTableView: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    let frameWidth: CGFloat
    
    var body: some View {
        VStack {
            Text("Degradation, %D [%]")
            Divider()
                .frame(width: frameWidth)
            ForEach (globalData.tableData.indices) { index in
                TextField("", text: $globalData.tableData[index].degradation)
                    .textFieldStyle(.roundedBorder)
                    .colorScheme(.light)
                    .frame(width: frameWidth)
                    .disabled(true)
                    .foregroundStyle(.black)
                    .onChange(of: globalData.tableData[index].degradation) {
                        let temp = globalData.tableData[index].degradation
                        if !temp.isInteger && !temp.isDouble && !temp.isEmpty {
                            globalData.tableData[index].degradation = temp.filter {$0.isNumber}
                        }
                    }
            }
        }
    }
}
