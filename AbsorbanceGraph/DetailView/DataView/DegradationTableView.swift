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
    
    var body: some View {
        VStack {
            Text("Degradation, %D [%]")
            Divider()
                .frame(width: 150)
            ForEach (globalData.outputData.indices) { index in
                TextField("", text: $globalData.outputData[index].degradation)
                    .frame(width: 150)
                    .disabled(true)
                    .onChange(of: globalData.outputData[index].degradation) {
                        let temp = globalData.outputData[index].degradation
                        if !temp.isInteger && !temp.isDouble && !temp.isEmpty {
                            globalData.outputData[index].degradation = temp.filter {$0.isNumber}
                        }
                    }
            }
        }
    }
}
