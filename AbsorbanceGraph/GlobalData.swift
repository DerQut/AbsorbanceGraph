//
//  GlobalData.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 14/03/2025.
//

import Foundation
import SwiftUI

enum concentrationUnit: String, CaseIterable {
    case mgL
    case ppm
}


class GlobalData: ObservableObject {
    @Published var concentrationUnit: concentrationUnit = .mgL
    
    @Published var absorbanceValues: [Double] = []
    @Published var timeValues: [Double] = []
    @Published var concentrationValues: [Double] = []
    @Published var degradationValues: [Double] = []
    
    @Published var isGraphClosed: Bool = true
    @Published var showGrid: Bool = true
    @Published var graphAxisFont: Int = 12
    
}
