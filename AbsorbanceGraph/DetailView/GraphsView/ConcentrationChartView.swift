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
    
    @State var xDomainMin: String = "0"
    @State var xDomainMax: String = "300"
    
    @State var xMajorStep: String = "100"
    @State var xMajorLines: [Double] = [0, 100, 200, 300]
    @State var xMinorStep: String = "50"
    @State var xMinorLines: [Double] = [0, 50, 100, 150, 200, 250, 300]
    
    @State var yDomainMin: String = "0"
    @State var yDomainMax: String = "300"
    
    @State var yMajorStep: String = "100"
    @State var yMajorLines: [Double] = [0, 100, 200, 300]
    @State var yMinorStep: String = "50"
    @State var yMinorLines: [Double] = [0, 50, 100, 150, 200, 250, 300]
    
    var body: some View {
        HStack {
            ZStack {
                Color(.white)
                Chart {
                    ForEach (globalData.tableData.filter{ !$0.timeStep.isEmpty && !$0.concentration.isEmpty }) { data in
                        if !data.timeStep.isEmpty && !data.concentration.isEmpty {
                            PointMark(
                                x: .value("Time", Double(data.timeStep)!),
                                y: .value("Concentration", Double(data.concentration)!)
                            )
                        }
                    }
                }
                .frame(width: 400, height: 300)
                .chartXScale(domain: (Double(xDomainMin) ?? 0)...(Double(xDomainMax) ?? 1))
                .chartYScale(domain: (Double(yDomainMin) ?? 0)...(Double(yDomainMax) ?? 1))
                
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
                    
                    AxisMarks(position: .leading, values: yMajorLines) { value in
                        if globalData.showGrid {
                            AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 0.5))
                                .foregroundStyle(Color(red: 0.25, green: 0.25, blue: 0.25))
                        }
                        
                        AxisValueLabel()
                            .font(Font.custom("TimesNewRomanPSMT", size: CGFloat(globalData.graphTickmarkFont)))
                            .foregroundStyle(.black)
                        
                        AxisTick(centered: true, length: -6, stroke: StrokeStyle(lineWidth: 2))
                            .foregroundStyle(.black)
                    }
                    
                    AxisMarks(values: [Double(yDomainMax) ?? 0]) { value in
                        if globalData.isGraphClosed {
                            AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 2))
                                .foregroundStyle(.black)
                        }
                    }
                }
                
                .chartXAxis {
                    AxisMarks(preset: .aligned, position: .bottom) { value in
                        
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
                    
                    AxisMarks(preset: .aligned, values: xMajorLines) { value in
                        if globalData.showGrid {
                            AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 0.5))
                                .foregroundStyle(Color(red: 0.25, green: 0.25, blue: 0.25))
                        }
                        
                        AxisValueLabel()
                            .font(Font.custom("TimesNewRomanPSMT", size: CGFloat(globalData.graphTickmarkFont)))
                            .foregroundStyle(.black)
                        
                        AxisTick(centered: true, length: -6, stroke: StrokeStyle(lineWidth: 2))
                            .foregroundStyle(.black)
                    }
                    
                    AxisMarks(values: [Double(xDomainMax) ?? 0]) { value in
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
                HStack {
                    Text("X range (min):")
                    Spacer()
                    TextField("", text: $xDomainMin)
                        .frame(width: 50)
                        .onChange(of: xDomainMin) {
                            if !xDomainMin.isDouble && !xDomainMin.isInteger && !xDomainMin.isEmpty {
                                xDomainMin = xDomainMin.filter { $0.isNumber }
                            }
                            updateXLines()
                        }
                }
                
                HStack {
                    Text("X range (max):")
                    Spacer()
                    TextField("", text: $xDomainMax)
                        .frame(width: 50)
                        .onChange(of: xDomainMax) {
                            if !xDomainMax.isDouble && !xDomainMax.isInteger && !xDomainMax.isEmpty {
                                xDomainMax = xDomainMax.filter { $0.isNumber }
                            }
                            updateXLines()
                        }
                }
                
                Divider()
                
                HStack {
                    Text("X grid step (minor):")
                    Spacer()
                    TextField("", text: $xMinorStep)
                        .frame(width: 50)
                        .onChange(of: xMinorStep) {
                            if !xMinorStep.isDouble && !xMinorStep.isInteger && !xMinorStep.isEmpty {
                                xMinorStep = xMinorStep.filter { $0.isNumber }
                            }
                            updateXLines()
                        }
                }
                
                HStack {
                    Text("X grid step (major):")
                    Spacer()
                    TextField("", text: $xMajorStep)
                        .frame(width: 50)
                        .onChange(of: xMajorStep) {
                            if !xMajorStep.isDouble && !xMajorStep.isInteger && !xMajorStep.isEmpty {
                                xMajorStep = xMajorStep.filter { $0.isNumber }
                            }
                            updateXLines()
                        }
                }
                
                Divider()
                
                HStack {
                    Text("Y range (min):")
                    Spacer()
                    TextField("", text: $yDomainMin)
                        .frame(width: 50)
                        .onChange(of: yDomainMin) {
                            if !yDomainMin.isDouble && !yDomainMin.isInteger && !yDomainMin.isEmpty {
                                yDomainMin = yDomainMin.filter { $0.isNumber }
                            }
                            updateYLines()
                        }
                }
                
                HStack {
                    Text("Y range (max):")
                    Spacer()
                    TextField("", text: $yDomainMax)
                        .frame(width: 50)
                        .onChange(of: yDomainMax) {
                            if !yDomainMax.isDouble && !yDomainMax.isInteger && !yDomainMax.isEmpty {
                                yDomainMax = yDomainMax.filter { $0.isNumber }
                            }
                            updateYLines()
                        }
                }
                
                Divider()
                
                HStack {
                    Text("Y grid step (minor):")
                    Spacer()
                    TextField("", text: $yMinorStep)
                        .frame(width: 50)
                        .onChange(of: yMinorStep) {
                            if !yMinorStep.isDouble && !yMinorStep.isInteger && !yMinorStep.isEmpty {
                                yMinorStep = yMinorStep.filter { $0.isNumber }
                            }
                            updateYLines()
                        }
                }
                
                HStack {
                    Text("Y grid step (major):")
                    Spacer()
                    TextField("", text: $yMajorStep)
                        .frame(width: 50)
                        .onChange(of: yMajorStep) {
                            if !yMajorStep.isDouble && !yMajorStep.isInteger && !yMajorStep.isEmpty {
                                yMajorStep = yMajorStep.filter { $0.isNumber }
                            }
                            updateYLines()
                        }
                }
            }
        }
    }
    
    func updateXLines() {
        
        if (Double(xDomainMin) ?? 0 >= Double(xDomainMax) ?? 1) {
            xDomainMin = "0"
            xDomainMax = "1"
            return
        }
        
        if let xMin = Double(xDomainMin), let xMax = Double(xDomainMax), let minorStep = Double(xMinorStep), let majorStep = Double(xMajorStep) {
            
            xMinorLines = []
            xMajorLines = []
            
            if (minorStep <= 0 || majorStep <= 0) { return }
            
            var i: Double = xMin
            while i <= xMax {
                xMinorLines.append(i)
                i += minorStep
            }
            
            i = xMin
            while i <= xMax {
                xMajorLines.append(i)
                i += majorStep
            }
        }
        
        
        
    }
    
    func updateYLines() {
        
        if (Double(yDomainMin) ?? 0 >= Double(yDomainMax) ?? 1) {
            yDomainMin = "0"
            yDomainMax = "1"
            return
        }
        
        if let yMin = Double(yDomainMin), let yMax = Double(yDomainMax), let minorStep = Double(yMinorStep), let majorStep = Double(yMajorStep) {
            
            yMinorLines = []
            yMajorLines = []
            
            if (minorStep <= 0 || majorStep <= 0) { return }
            
            var i: Double = yMin
            while i <= yMax {
                yMinorLines.append(i)
                i += minorStep
            }
            
            i = yMin
            while i <= yMax {
                yMajorLines.append(i)
                i += majorStep
            }
        }
        
        
        
    }
}
