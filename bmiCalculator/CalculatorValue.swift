//
//  CalculatorValue.swift
//  Calculator
//
//  Created by Jane Chao on 2024/4/17.
//

import Foundation

enum CalculatorValue {
    case number(Decimal)
    case mathOperator(MathOperator)
    
    var description: String {
        switch self {
            case .number(let decimal): decimal.description
            case .mathOperator(let mathOperator): mathOperator.mathSymbol
        }
    }
    
    var number: Decimal? {
        switch self {
            case .number(let decimal): decimal
            case .mathOperator: nil
        }
    }
    
    var mathOperator: MathOperator? {
        switch self {
            case .number: nil
            case .mathOperator(let mathOperator): mathOperator
        }
    }
}
