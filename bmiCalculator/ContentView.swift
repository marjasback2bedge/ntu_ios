//
//  ContentView.swift
//  Calculator
//
//  Created by Jane Chao on 2024/3/14.
//

import SwiftUI

struct ContentView: View {
    @State var calculator = Calculator()
    @State var shouldShowSettingsSheet: Bool = false
    
    @AppStorage("mainColor") var mainColor = Color.orange
    @AppStorage("secondaryColor") var secondaryColor = Color(.systemGray4)
    @AppStorage("numberColor") var numberColor = Color.secondary
    @AppStorage("fontStyle") var fontStyle = Font.Design.default
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 16) {
            VStack(alignment: .trailing, spacing: 16) {
                Text(calculator.displayedExpression)
                Text(calculator.displayedValue)
                    .font(.system(size: 90))
                    .layoutPriority(1)
                    .lineLimit(2)
            }
            .truncationMode(.head)
            .minimumScaleFactor(0.6)
            .allowsTightening(true)
            .multilineTextAlignment(.trailing)
            .containerRelativeFrame(.vertical, count: 3, spacing: 16, alignment: .bottomTrailing)
            
            Grid(alignment: .bottomTrailing, horizontalSpacing: 16, verticalSpacing: 16) {
                GridRow {
                    secondaryButton("C") { calculator.undo() }
                    secondaryButton("\(Image(systemName: "plus.forwardslash.minus"))") { calculator.toggleSign() }
                    secondaryButton("\(Image(systemName: "percent"))") {
                        calculator.convertFromPercentage()
                    }
                    mainButton(mathOperator: .divide)
                }
                
                GridRow {
                    numberButton(7)
                    numberButton(8)
                    numberButton(9)
                    mainButton(mathOperator: .multiply)
                }
                
                
                GridRow {
                    numberButton(4)
                    numberButton(5)
                    numberButton(6)
                    mainButton(mathOperator: .subtract)
                }
                
                GridRow {
                    numberButton(1)
                    numberButton(2)
                    numberButton(3)
                    mainButton(mathOperator: .add)
                }
                
                
                GridRow {
                    numberButton("", shape: .capsule) {
                        calculator.pressNumber(0)
                    }
                    .gridCellUnsizedAxes(.vertical)
                    .gridCellColumns(2)
                    .overlay {
                        HStack(spacing: 16) {
                            Color.clear
                                .overlay {
                                    Text("0")
                                }
                            Color.clear
                        }
                    }
                    
                    numberButton(".") { calculator.pressDot() }
                    mainButton(mathOperator: .equal)
                }
            }
        }
        .fontDesign(fontStyle)
        .foregroundStyle(.white)
        .font(.largeTitle)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .background(Color.black)
        .overlay(alignment: .topLeading) {
            Button {
                shouldShowSettingsSheet = true
            } label: {
                Image(systemName: "gear")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
            }
        }
        .sheet(isPresented: $shouldShowSettingsSheet) {
            SettingsView(mainColor: $mainColor, secondaryColor: $secondaryColor, numberColor: $numberColor, fontStyle: $fontStyle) 
                .presentationDetents([.medium, .large])
        }
    }
    
    func mainButton(mathOperator: MathOperator) -> some View {
        Button {
            calculator.pressOperator(mathOperator)
        } label: {
            Circle()
                .foregroundStyle(mainColor)
                .overlay {
                    Image(systemName: mathOperator.systemName)
                }
        }
    }
    
    func numberButton(_ number: Int, shape: some Shape = .circle) -> some View {
        numberButton(number.description, shape: shape) {
            calculator.pressNumber(number)
        }
    }
    
    func numberButton(_ label: String, shape: some Shape = .circle, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            shape
                .foregroundStyle(numberColor)
                .overlay {
                    Text(label)
                }
        }
    }
    
    func secondaryButton(_ label: LocalizedStringKey, 
                         action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Circle()
                .foregroundStyle(secondaryColor)
                .overlay {
                    Text(label)
                        .foregroundStyle(.black)
                }
        }
    }
    
}

#Preview {
    ContentView()
}
