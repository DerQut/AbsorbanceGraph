//
//  GraphSettingsView.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 14/03/2025.
//

import SwiftUI
import Foundation

struct GraphSettingsView: View {
    
    @EnvironmentObject var globalData: GlobalData
    @State var isShown: Bool = true
    
    #if os(iOS)
    var paddingInset: CGFloat = 36
    #else
    var paddingInset: CGFloat = 28
    #endif
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "chevron.down")
                    .foregroundStyle(Color.accentColor)
                    .rotationEffect(Angle(degrees: -180 * (isShown ? 1 : 0)))
                Text("Graph settings")
                Spacer()
            }
            .font(.title2)
            .onTapGesture {
                isShown.toggle()
            }
            
            if isShown {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Close graphs:")
                        Spacer()
                        Toggle("Close graphs", isOn: $globalData.isGraphClosed)
                            .labelsVisibility(.hidden)
                    }
                    
                    HStack {
                        Text("Use grids:")
                        Spacer()
                        Toggle("Use grids", isOn: $globalData.showGrid)
                            .labelsVisibility(.hidden)
                    }
                    
                    HStack{
                        Text("Axis font size:")
                        Spacer()
                        Stepper(globalData.graphAxisFont.description, value: $globalData.graphAxisFont, in: 1...32, step: 1)
                            .foregroundStyle(Color.accentColor)
                    }
                    
                    HStack {
                        Text("Tickmark font size:")
                        Spacer()
                        Stepper(globalData.graphTickmarkFont.description, value: $globalData.graphTickmarkFont, in: 1...32, step: 1)
                            .foregroundStyle(Color.accentColor)
                    }
                }
                .padding(.leading, paddingInset)
            }
        }
    }
}
