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
                    Stepper(globalData.graphAxisFont.description, value: $globalData.graphAxisFont, in: 1...24, step: 1)
                        .foregroundStyle(Color.accentColor)
                }

            }
            .padding(.leading, 28)
            .scaleEffect(y: isShown ? 1 : 0, anchor: .top)
            .opacity(isShown ? 1 : 0)
        }
        .animation(.default, value: isShown)
    }
}
