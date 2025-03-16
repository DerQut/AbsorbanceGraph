//
//  GraphsView.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 14/03/2025.
//

import SwiftUI

struct GraphsView: View {
    var body: some View {
        ScrollView {
            VStack {
                ConcentrationChartView()
                Spacer()
            }
        }
    }
}
