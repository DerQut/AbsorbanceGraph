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
        
        self.tableData.filter {
            !$0.absorbance.isEmpty
        }.indices.filter {
            $0 != 0
        }.forEach { i in
            self.tableData[i].concentration = String(Double(self.tableData[0].concentration)! * Double(self.tableData[i].absorbance)! / Double(self.tableData[0].absorbance)!)
            
            self.tableData[i].degradation = String(
                100 * (1 - Double(self.tableData[i].concentration)! / Double(self.tableData[0].concentration)!)
            )
        }
    }
    
}
