//
//  AbsorbanceChartView.swift
//  AbsorbanceGraph
//
//  Created by Marcel Chołodecki on 17/03/2025.
//

import SwiftUI
import Charts


struct AbsorbanceChartView: View {
    @EnvironmentObject var globalData: GlobalData
    
    @State var xDomainMinBuffer: String = "0"
    @State var xDomainMaxBuffer: String = "300"
    
    @State var xDomainMin: Double = 0
    @State var xDomainMax: Double = 300
    
    @State var xMajorStep: String = "100"
    @State var xMajorLines: [Double] = [0, 100, 200, 300]
    @State var xMinorStep: String = "50"
    @State var xMinorLines: [Double] = [0, 50, 100, 150, 200, 250, 300]
    
    @State var yDomainMinBuffer: String = "0"
    @State var yDomainMaxBuffer: String = "2"
    
    @State var yDomainMin: Double = 0
    @State var yDomainMax: Double = 2
    
    @State var yMajorStep: String = "0.5"
    @State var yMajorLines: [Double] = [0, 0.5, 1, 1.5, 2]
    @State var yMinorStep: String = "0.1"
    @State var yMinorLines: [Double] = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2]
    
    var body: some View {
        HStack {
            ZStack {
                Color(.white)
                Chart {
                    ForEach (globalData.tableData.filter{ !$0.timeStep.isEmpty && !$0.absorbance.isEmpty }) { data in
                        if !data.timeStep.isEmpty && !data.absorbance.isEmpty {
                            PointMark(
                                x: .value("Time", Double(data.timeStep)!),
                                y: .value("Absorbance", Double(data.absorbance)!)
                            )
                        }
                    }
                }
                .frame(width: 400, height: 300)
                .chartXScale(domain: (xDomainMin...xDomainMax))
                .chartYScale(domain: (yDomainMin...yDomainMax))
                
                .chartXAxisLabel(position: .bottom, alignment: .center) {
                    Text("Time, t [\(globalData.timeUnit)]")
                        .font(Font.custom("TimesNewRomanPSMT", size: CGFloat(globalData.graphAxisFont)))
                        .foregroundStyle(.black)
                        .padding(8)
                }
                
                .chartYAxisLabel(position: .leading) {
                    Text("Absorbance, A [\(globalData.absorbanceUnit)]")
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
                    
                    AxisMarks(values: [yDomainMax]) { value in
                        if globalData.isGraphClosed {
                            AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 2))
                                .foregroundStyle(.black)
                        }
                    }
                }
                
                .chartXAxis {
                    AxisMarks(preset: .aligned, position: .bottom, values: [xMinorLines.first ?? 0]) { value in
                        
                        AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 2))
                            .foregroundStyle(.black)
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
                HStack {
                    Text("X range (min):")
                    Spacer()
                    TextField("", text: $xDomainMinBuffer)
                        .textFieldStyle(.roundedBorder)
                        .colorScheme(.light)
                        .frame(width: 50)
                        .onChange(of: xDomainMinBuffer) {
                            if !xDomainMinBuffer.isDouble && !xDomainMinBuffer.isInteger && !xDomainMinBuffer.isEmpty {
                                xDomainMinBuffer = xDomainMinBuffer.filter { $0.isNumber }
                            }
                            updateXLines()
                        }
                }
                
                HStack {
                    Text("X range (max):")
                    Spacer()
                    TextField("", text: $xDomainMaxBuffer)
                        .textFieldStyle(.roundedBorder)
                        .colorScheme(.light)
                        .frame(width: 50)
                        .onChange(of: xDomainMaxBuffer) {
                            if !xDomainMaxBuffer.isDouble && !xDomainMaxBuffer.isInteger && !xDomainMaxBuffer.isEmpty {
                                xDomainMaxBuffer = xDomainMaxBuffer.filter { $0.isNumber }
                            }
                            updateXLines()
                        }
                }
                
                Divider()
                
                HStack {
                    Text("X grid step (minor):")
                    Spacer()
                    TextField("", text: $xMinorStep)
                        .textFieldStyle(.roundedBorder)
                        .colorScheme(.light)
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
                        .textFieldStyle(.roundedBorder)
                        .colorScheme(.light)
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
                    TextField("", text: $yDomainMinBuffer)
                        .textFieldStyle(.roundedBorder)
                        .colorScheme(.light)
                        .frame(width: 50)
                        .onChange(of: yDomainMinBuffer) {
                            if !yDomainMinBuffer.isDouble && !yDomainMinBuffer.isInteger && !yDomainMinBuffer.isEmpty {
                                yDomainMinBuffer = yDomainMinBuffer.filter { $0.isNumber }
                            }
                            updateYLines()
                        }
                }
                
                HStack {
                    Text("Y range (max):")
                    Spacer()
                    TextField("", text: $yDomainMaxBuffer)
                        .textFieldStyle(.roundedBorder)
                        .colorScheme(.light)
                        .frame(width: 50)
                        .onChange(of: yDomainMaxBuffer) {
                            if !yDomainMaxBuffer.isDouble && !yDomainMaxBuffer.isInteger && !yDomainMaxBuffer.isEmpty {
                                yDomainMaxBuffer = yDomainMaxBuffer.filter { $0.isNumber }
                            }
                            updateYLines()
                        }
                }
                
                Divider()
                
                HStack {
                    Text("Y grid step (minor):")
                    Spacer()
                    TextField("", text: $yMinorStep)
                        .textFieldStyle(.roundedBorder)
                        .colorScheme(.light)
                        .frame(width: 50)
                        .onChange(of: yMinorStep) {
                            if !yMinorStep.isDouble && !yMinorStep.isInteger && !yMinorStep.isEmpty {
                                yMinorStep = yMinorStep.filter { $0.isNumber}
                            }
                            updateYLines()
                        }
                }
                
                HStack {
                    Text("Y grid step (major):")
                    Spacer()
                    TextField("", text: $yMajorStep)
                        .textFieldStyle(.roundedBorder)
                        .colorScheme(.light)
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
        
        if let xMin = Double(xDomainMinBuffer), let xMax = Double(xDomainMaxBuffer), let minorStep = Double(xMinorStep), let majorStep = Double(xMajorStep) {
            
            if (minorStep <= 0 || majorStep <= 0) { return }
            if (xMin >= xMax) { return }
            
            xDomainMin = xMin
            xDomainMax = xMax
            
            xMinorLines = []
            xMajorLines = []
            
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
        
        if let yMin = Double(yDomainMinBuffer), let yMax = Double(yDomainMaxBuffer), let minorStep = Double(yMinorStep), let majorStep = Double(yMajorStep) {
            
            if (minorStep <= 0 || majorStep <= 0) { return }
            if (yMin >= yMax) { return }
            
            yDomainMin = yMin
            yDomainMax = yMax
            
            yMinorLines = []
            yMajorLines = []
            
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
