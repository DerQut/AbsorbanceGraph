//
//  GlobalData.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 14/03/2025.
//

import Foundation
import SwiftUI


extension String {
    var isInteger: Bool { return Int(self) != nil }
    var isFloat: Bool { return Float(self) != nil }
    var isDouble: Bool { return Double(self) != nil }
}


enum ConcentrationUnit: String, Equatable, CaseIterable {
    case mgL = "mg/l"
    case ppm = "ppm"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

enum TimeUnit: String, Equatable, CaseIterable {
    case s = "s"
    case min = "min"
    case h = "h"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}


struct TableData: Identifiable {
    let id = UUID()
    var timeStep: String = ""
    var absorbance: String = ""
    var concentration: String = ""
    var degradation: String = ""
}


class GlobalData: ObservableObject {

    @Published var tableData: [TableData] = [
        TableData(timeStep: "0", absorbance: "1.6", concentration: "250"),
        TableData(timeStep: "15", absorbance: "1.5"),
        TableData(timeStep: "30", absorbance: "1.4"),
        TableData(timeStep: "60", absorbance: "1.37"),
        TableData(timeStep: "120", absorbance: "1.35"),
        TableData(timeStep: "180", absorbance: "1.31"),
        TableData(timeStep: "240", absorbance: "1.28")
    ]
    
    
    @Published var isGraphClosed: Bool = true
    @Published var showGrid: Bool = true
    @Published var graphAxisFont: Int = 16
    @Published var graphTickmarkFont: Int = 12
    
    @Published var showScatter: Bool = true
    @Published var showLine: Bool = false
    
    @Published var scatterColor: Color = .accentColor
    @Published var lineColor: Color = .black
    
    @Published var timeUnit: TimeUnit = .min
    @Published var absorbanceUnit: String = "a.u."
    @Published var concentrationUnit: ConcentrationUnit = .ppm
    
    
    init() {
        self.recalculateAll()
    }
    
    
    func recalculateAll() {
        if self.tableData[0].concentration.isEmpty { return }
        if self.tableData[0].absorbance.isEmpty { return }
        
        self.tableData[0].degradation = "0"
        
        if let concentration0 = Double(tableData[0].concentration), let absorbance0 = Double(tableData[0].absorbance) {
            for i in 1..<self.tableData.count {
                if let absorbance1 = Double(self.tableData[i].absorbance) {
                    self.tableData[i].concentration = String(concentration0 * absorbance1 / absorbance0)
                    if let concentration1 = Double(tableData[i].concentration) {
                        self.tableData[i].degradation = String(100 * (concentration0 - concentration1) / concentration0)
                    }
                } else {
                    self.tableData[i].concentration = ""
                    self.tableData[i].degradation = ""
                }
            }
        }
    }
    
}
