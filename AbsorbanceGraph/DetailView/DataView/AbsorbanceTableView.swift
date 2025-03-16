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
    
    var body: some View {
        VStack {
            Text("Absorbance, A [\(globalData.absorbanceUnit)]")
            Divider()
                .frame(width: 150)
            ForEach (globalData.inputData.indices) { index in
                TextField("", text: $globalData.inputData[index].absorbance)
                    .frame(width: 150)
                    .onChange(of: globalData.inputData[index].absorbance) {
                        let temp = globalData.inputData[index].absorbance
                        if !temp.isInteger && !temp.isDouble && !temp.isEmpty {
                            globalData.inputData[index].absorbance = temp.filter {$0.isNumber}
                        }
                    }
            }
        }
    }
}
