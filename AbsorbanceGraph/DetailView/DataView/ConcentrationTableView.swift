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
    
    let frameWidth: CGFloat
    
    var body: some View {
        VStack {
            Text("Concentration, c [\(globalData.concentrationUnit == .ppm ? "ppm" : "mg/l")]")
            Divider()
                .frame(width: frameWidth)
            ForEach (globalData.tableData.indices) { index in
                TextField("", text: $globalData.tableData[index].concentration)
                    .textFieldStyle(.roundedBorder)
                    .colorScheme(.light)
                    .foregroundStyle(.black)
                    .frame(width: frameWidth)
                    .disabled(index != 0)
                    .onChange(of: globalData.tableData[index].concentration) {
                        let temp = globalData.tableData[index].concentration
                        if !temp.isInteger && !temp.isDouble && !temp.isEmpty {
                            globalData.tableData[index].concentration = temp.filter {$0.isNumber}
                        }
                        if index == 0 {
                            globalData.recalculateAll()
                        }
                    }
            }
        }
    }
}
