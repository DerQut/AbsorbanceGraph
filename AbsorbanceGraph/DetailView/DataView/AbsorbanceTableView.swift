//
//  AbsorbanceTableView.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 16/03/2025.
//

import Foundation
import SwiftUI

struct AbsorbanceTableView: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    let frameWidth: CGFloat
    
    var body: some View {
        VStack {
            Text("Absorbance, A [\(globalData.absorbanceUnit)]")
            Divider()
                .frame(width: frameWidth)
            ForEach (globalData.tableData.indices) { index in
                TextField("", text: $globalData.tableData[index].absorbance)
                    .textFieldStyle(.roundedBorder)
                    .colorScheme(.light)
                    .frame(width: frameWidth)
                    .onChange(of: globalData.tableData[index].absorbance) {
                        let temp = globalData.tableData[index].absorbance
                        if !temp.isInteger && !temp.isDouble && !temp.isEmpty {
                            globalData.tableData[index].absorbance = temp.filter {$0.isNumber}
                        }
                        globalData.recalculateAll()
                    }
            }
        }
    }
}
