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
    @State var isShown: Bool = false
    @State var isFontPickerShown: Bool = false
    
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
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Close graphs")
                    Spacer()
                    Toggle("Close graphs", isOn: $globalData.isGraphClosed)
                        .labelsVisibility(.hidden)
                }
                
                HStack {
                    Text("Use grid")
                    Spacer()
                    Toggle("Use grid", isOn: $globalData.showGrid)
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
            .scaleEffect(y: isShown ? 1 : 0, anchor: .top)
            .opacity(isShown ? 1 : 0)
        }
        .animation(.default, value: isShown)
    }
}
