//
//  ConcentrationChartView.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 16/03/2025.
//

import SwiftUI
import Charts


struct ConcentrationChartView: View {
    @EnvironmentObject var globalData: GlobalData
    
    @State var xDomainMin: Double = 0
    @State var xDomainMax: Double = 300
    
    @State var xMajorStep: Double = 100
    @State var xMajorLines: [Double] = [100, 200]
    @State var xMinorStep: Double = 50
    @State var xMinorLines: [Double] = [50, 100, 150, 200, 250]
    
    @State var yDomainMin: Double = 0
    @State var yDomainMax: Double = 300
    
    @State var yMajorStep: Double = 100
    @State var yMajorLines: [Double] = [100, 200]
    @State var yMinorStep: Double = 50
    @State var yMinorLines: [Double] = [50, 100, 150, 200, 250]
    
    var body: some View {
        HStack {
            ZStack {
                Color(.white)
                Chart {
                    ForEach (globalData.tableData) { data in
                        if !data.timeStep.isEmpty && !data.concentration.isEmpty {
                            PointMark(
                                x: .value("Time", Double(data.timeStep)!),
                                y: .value("Concentration", Double(data.concentration)!)
                            )
                        }
                    }
                }
                .frame(width: 400, height: 300)
                
                .chartXAxisLabel(position: .bottom, alignment: .center) {
                    Text("Time, t [\(globalData.timeUnit)]")
                        .font(Font.custom("TimesNewRomanPSMT", size: CGFloat(globalData.graphAxisFont)))
                        .foregroundStyle(.black)
                        .padding(8)
                }
                
                .chartYAxisLabel(position: .leading) {
                    Text("Concentration, c [\(globalData.concentrationUnit == .mgL ? "mg/l" : "ppm")]")
                        .font(Font.custom("TimesNewRomanPSMT", size: CGFloat(globalData.graphAxisFont)))
                        .foregroundStyle(.black)
                        .rotationEffect(.degrees(180))
                        .padding(8)
                }
                
                .chartYAxis {
                    AxisMarks(preset: .aligned, position: .leading) { value in
                        AxisValueLabel()
                            .font(Font.custom("TimesNewRomanPSMT", size: CGFloat(globalData.graphTickmarkFont)))
                            .foregroundStyle(.black)
                        
                        AxisTick(centered: true, length: -6, stroke: StrokeStyle(lineWidth: 2))
                            .foregroundStyle(.black)
                        
                        if value.index == 0 {
                            AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 2))
                                .foregroundStyle(.black)
                        }
                    }
                    
                    AxisMarks(values: yMinorLines) { value in
                        if globalData.showGrid {
                            AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 0.25, dash: [3]))
                                .foregroundStyle(Color(red: 0.5, green: 0.5, blue: 0.5))
                        }
                    }
                    
                    AxisMarks(values: yMajorLines) { value in
                        if globalData.showGrid {
                            AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 0.5))
                                .foregroundStyle(Color(red: 0.25, green: 0.25, blue: 0.25))
                        }
                    }
                    
                    AxisMarks(values: [yDomainMax]) { value in
                        if globalData.isGraphClosed {
                            AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 2))
                                .foregroundStyle(.black)
                        }
                    }
                }
                
                .chartXAxis {
                    AxisMarks(preset: .aligned, position: .bottom) { value in
                        AxisValueLabel()
                            .font(Font.custom("TimesNewRomanPSMT", size: CGFloat(globalData.graphTickmarkFont)))
                            .foregroundStyle(.black)
                        
                        AxisTick(centered: true, length: -6, stroke: StrokeStyle(lineWidth: 2))
                            .foregroundStyle(.black)
                        
                        if value.index == 0 {
                            AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 2))
                                .foregroundStyle(.black)
                        }
                    }
                    
                    AxisMarks(values: xMinorLines) { value in
                        if globalData.showGrid {
                            AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 0.25, dash: [3]))
                                .foregroundStyle(Color(red: 0.5, green: 0.5, blue: 0.5))
                        }
                    }
                    
                    AxisMarks(values: xMajorLines) { value in
                        if globalData.showGrid {
                            AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 0.5))
                                .foregroundStyle(Color(red: 0.25, green: 0.25, blue: 0.25))
                        }
                    }
                    
                    AxisMarks(values: [xDomainMax]) { value in
                        if globalData.isGraphClosed {
                            AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 2))
                                .foregroundStyle(.black)
                        }
                    }
                }
                
                .padding()
                .preferredColorScheme(.light)
            }
            
            VStack {
                Text("ajajaj")
            }
        }
    }
}
