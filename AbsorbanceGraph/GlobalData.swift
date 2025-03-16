//
//  GlobalData.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 14/03/2025.
//

import Foundation
import SwiftUI

enum ConcentrationUnit: String, Equatable, CaseIterable {
    case mgL = "mg/l"
    case ppm = "ppm"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

extension String {
    var isInteger: Bool { return Int(self) != nil }
    var isFloat: Bool { return Float(self) != nil }
    var isDouble: Bool { return Double(self) != nil }
}


class GlobalData: ObservableObject {
    
    @Published var absorbanceValues: [Double] = []
    @Published var timeValues: [Double] = []
    @Published var concentrationValues: [Double] = []
    @Published var degradationValues: [Double] = []
    
    @Published var isGraphClosed: Bool = true
    @Published var showGrid: Bool = true
    @Published var graphAxisFont: Int = 12
    @Published var graphTickmarkFont: Int = 12
    
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
    
}
