//
//  GraphSettingsView.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 14/03/2025.
//

import SwiftUI
import Foundation

struct GraphSettingsView: View {
    
    @State var isShown: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "chevron.down")
                    .foregroundStyle(Color.accentColor)
                    .rotationEffect(Angle(degrees: -180 * (isShown ? 1 : 0)))
                Text("Graph settings")
                Spacer()
            }
            .onTapGesture {
                isShown.toggle()
            }
            
            VStack {
                Text("aa")
            }
            .padding(.horizontal, 24)
            .scaleEffect(y: isShown ? 1 : 0)
            .opacity(isShown ? 1 : 0)
        }
        .animation(.default, value: isShown)
    }
}
