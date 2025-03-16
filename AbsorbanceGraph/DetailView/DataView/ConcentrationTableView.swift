//
//  ConcentrationTableView.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 16/03/2025.
//

import Foundation
import SwiftUI


struct ConcentrationTableView: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    var body: some View {
        VStack {
            Text("Concentration, c [\(globalData.concentrationUnit == .ppm ? "ppm" : "mg/l")]")
            Divider()
                .frame(width: 150)
            ForEach (globalData.outputData.indices) { index in
                TextField("", text: $globalData.outputData[index].concentration)
                    .frame(width: 150)
                    .disabled(index != 0)
                    .onChange(of: globalData.outputData[index].concentration) {
                        let temp = globalData.outputData[index].concentration
                        if !temp.isInteger && !temp.isDouble && !temp.isEmpty {
                            globalData.outputData[index].concentration = temp.filter {$0.isNumber}
                        }
                    }
            }
        }
    }
}
