//
//  SideBarView.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 14/03/2025.
//

import SwiftUI

struct SideBarView: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                DataSettingsView()
                    .padding(.horizontal)
                    .padding(.top)
                
                GraphSettingsView()
                    .padding(.horizontal)
                    .padding(.top)
                
                Spacer()
            }
        }
    }
}
