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


struct InputData: Identifiable {
    let id = UUID()
    var timeStep: String
    var absorbance: String
}

struct OutputData: Identifiable {
    let id = UUID()
    var concentration: String
    var degradation: String
}


class GlobalData: ObservableObject {
    

    @Published var inputData: [InputData] = [
        InputData(timeStep: "0", absorbance: ""),
        InputData(timeStep: "15", absorbance: ""),
        InputData(timeStep: "30", absorbance: ""),
        InputData(timeStep: "60", absorbance: ""),
        InputData(timeStep: "120", absorbance: ""),
        InputData(timeStep: "180", absorbance: ""),
        InputData(timeStep: "240", absorbance: "")
    ]
    
    @Published var outputData: [OutputData] = []
    
    @Published var isGraphClosed: Bool = true
    @Published var showGrid: Bool = true
    @Published var graphAxisFont: Int = 12
    @Published var graphTickmarkFont: Int = 12
    
    @Published var timeUnit: TimeUnit = .min
    @Published var absorbanceUnit: String = "a.u."
    @Published var concentrationUnit: ConcentrationUnit = .ppm
    
    @Published var solventDensity: String = "1.000" {
        didSet {
            if !solventDensity.isDouble && !solventDensity.isInteger && !solventDensity.isEmpty {
                solventDensity = ""
            }
        }
    }
    
    @Published var soluteDensity: String = "1.000" {
        didSet {
            if !soluteDensity.isDouble && !soluteDensity.isInteger && !soluteDensity.isEmpty {
                soluteDensity = ""
            }
        }
    }
    
    
    init() {
        while (self.outputData.count < self.inputData.count) {
            outputData.append(OutputData(concentration: "", degradation: ""))
        }
    }
    
    
    func recalculateAll() {
        if self.outputData[0].concentration.isEmpty { return }
        if self.inputData[0].absorbance.isEmpty { return }
        
        self.outputData[0].degradation = "0"
        
        self.inputData.filter {
            !$0.absorbance.isEmpty
        }.indices.filter {
            $0 != 0
        }.forEach { i in
            self.outputData[i].concentration = String(Double(self.outputData[0].concentration)! * Double(self.inputData[i].absorbance)! / Double(self.inputData[0].absorbance)!)
            
            self.outputData[i].degradation = String(
                100 * (1 - Double(self.outputData[i].concentration)! / Double(self.outputData[0].concentration)!)
            )
        }
    }
    
}
