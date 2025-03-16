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
    
}
