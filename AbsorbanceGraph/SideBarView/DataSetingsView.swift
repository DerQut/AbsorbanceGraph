//
//  DataSetingsView.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 15/03/2025.
//

import SwiftUI
import Foundation

struct DataSettingsView: View {
    
    @EnvironmentObject var globalData: GlobalData
    @State var isShown: Bool = true
    
    #if os(iOS)
    var paddingInset: CGFloat = 36
    var frameWidth: CGFloat = 100
    #else
    var paddingInset: CGFloat = 28
    var frameWidth: CGFloat = 75
    #endif
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "chevron.down")
                    .foregroundStyle(Color.accentColor)
                    .rotationEffect(Angle(degrees: -180 * (isShown ? 1 : 0)))
                Text("Data settings")
                Spacer()
            }
            .font(.title2)
            .onTapGesture {
                isShown.toggle()
            }
            
            if isShown {
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("Time unit:")
                        Spacer()
                        Picker("", selection: $globalData.timeUnit) {
                            ForEach(TimeUnit.allCases, id: \.self) { value in
                                Text(value.localizedName)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(width: frameWidth)
                    }
                    
                    HStack {
                        Text("Absorbance unit:")
                        Spacer()
                        TextField("", text: $globalData.absorbanceUnit)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: frameWidth)
                    }
                    
                    HStack {
                        Text("Concentration unit:")
                        Spacer()
                        Picker("", selection: $globalData.concentrationUnit) {
                            ForEach(ConcentrationUnit.allCases, id: \.self) { value in
                                Text(value.localizedName)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(width: frameWidth)
                    }
                    
                    if false && globalData.concentrationUnit == .ppm {
                        HStack {
                            Text("Solvent density:")
                            Spacer()
                            TextField("", text: $globalData.solventDensity)
                                .frame(width: frameWidth)
                        }
                        
                        HStack {
                            Text("Solute density:")
                            Spacer()
                            TextField("", text: $globalData.soluteDensity)
                                .frame(width: frameWidth)
                        }
                    }
                    
                }
                .padding(.leading, paddingInset)
            }
        }
    }
}
