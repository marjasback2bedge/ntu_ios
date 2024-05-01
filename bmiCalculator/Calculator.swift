//
//  Calculator.swift
//  Calculator
//
//  Created by Jane Chao on 2024/3/21.
//

import Foundation

/// 計算機運算邏輯
struct Calculator {
    /// 目前的運算式紀錄
    var displayedExpression: String {
        expression.map(\.description).joined(separator: " ")
    }
    /// 錯誤訊息或是正在編輯的的值
    var displayedValue: String {
        errorMessage ?? currentValue
    }
    /// 保有類型資訊的運算式紀錄
    private var expression: [CalculatorValue]
    /// 錯誤訊息
    private var errorMessage: String?
    
    private var currentValue: String
    
    var isCurrentValueOperator: Bool {
        MathOperator(rawValue: currentValue) != nil
    }
    
    // 方便測試的啟動，請不要修改啟動參數，但請讓它能被成功執行
    init(expression: [CalculatorValue] = [], currentValue: String = "0", errorMessage: String? = nil) {
        self.expression = expression
        self.currentValue = currentValue
        self.errorMessage = errorMessage
    }
    
    mutating func pressNumber(_ number: Int){
        // 如果有錯誤的話，不執行任何動作。
        if errorMessage != nil { return }
        
        // 如果是零的話，直接取代現在的數字
        if currentValue == "0" {
            currentValue = number.description
        } else if isCurrentValueOperator {
            // 如果剛按完符號，把符號存起來，顯示新的數字
            saveCurrentValue()
            currentValue = number.description
        } else {
            // 在現在顯示的數字後面加上數字
            currentValue += number.description
        }
    }
    
    mutating func pressDot() {
        // 如果有錯誤的話，不執行任何動作。
        if errorMessage != nil { return }
        
        // 如果已經有點的話，不起作用
        if currentValue.contains(".") { return }
        
        if isCurrentValueOperator {
            // 如果剛按完符號，把符號存起來直接變成 0.
            saveCurrentValue()
            currentValue = "0."
        } else {
            currentValue += "."
        }
    }
    
    mutating func pressOperator(_ operation: MathOperator) {
        // 如果有錯誤的話，不執行任何動作。
        if errorMessage != nil { return }
        
        // 如果已經有符號被選中，切換符號
        if isCurrentValueOperator {
            currentValue = operation.mathSymbol
        } else {
            // 把現在的數字存起來，顯示剛剛按的符號
            saveCurrentValue()
            currentValue = operation.mathSymbol
        }
        
        // 如果是等號的話，確保運算式不是符號結尾，運算更新答案並清空紀錄。
        if operation == .equal {
            if !isCurrentValueOperator {
                saveCurrentValue()
            }
            let result = evaluate(expression: expression)
            currentValue = result.description
            expression = []
        }
    }
    
    mutating func undo() {
        if errorMessage != nil {
            // 如果有錯誤的話，刪除錯誤並顯示上一個值。
            errorMessage = nil
        }
        // 清除現在的值、變成上一個值。
        currentValue = expression.popLast()?.description ?? "0"
    }
    
    mutating func toggleSign() {
        // 如果有錯誤的話，不執行任何動作。
        if errorMessage != nil { return }
        
        // 如果是零就不做動作。
        // 如果剛按完符號，不起作用。
        if currentValue == "0" || isCurrentValueOperator { return }
        
        // 切換正負號
        if currentValue.first == "-" {
            currentValue.removeFirst()
        } else {
            currentValue = "-" + currentValue
        }
    }
    
    mutating func convertFromPercentage() {
        // 如果有錯誤的話，不執行任何動作。
        if errorMessage != nil { return }
        
        // 如果是零就不做動作。
        // 如果剛按完符號，不起作用。
        if let number = Decimal(string: currentValue), !number.isZero {
            // 現在的值除以 100
            currentValue = (number / 100).description
        }
    }
}

private extension Calculator {
    func evaluate(expression: [CalculatorValue]) -> Decimal {
        // * 標準 CS 答案應用 「Shunting Yard Algorithm」，以下是個較好懂的簡單寫法。
        
        // 新增一份紀錄乘除後剩下的運算式的 array
        var secondExpression = [CalculatorValue]()
        
        // 1. 先乘除，把剩下的運算式放入 secondExpression。
        var index = 0
        
        while index < expression.count {
            defer { index += 1 } // 每 loop 一次自動幫 index + 1
            let component = expression[index]
            switch component {
                case .number:
                    secondExpression.append(component)
                    
                case .mathOperator(let mathOperator):
                    guard
                        let firstNumber = secondExpression.last?.number,
                        let secondNumber = expression[index + 1].number
                    else {
                        fatalError("運算式內容有誤")
                    }
                    
                    let computeResult: Decimal
                    
                    switch mathOperator {
                        case .add, .subtract, .equal:
                            secondExpression.append(component)
                            continue
                        case .multiply:
                            computeResult = firstNumber * secondNumber
                        case .divide:
                            computeResult = firstNumber / secondNumber
                    }
                    
                    _ = secondExpression.popLast()
                    secondExpression.append(.number(computeResult))
                    index += 1
            }
        }
        
        
        // 2. 後加減（奇數 index 都會是符號）
        guard let firstNumber = secondExpression.first?.number else {
            fatalError("運算式內容有誤")
        }
        
        var sum = firstNumber
        for index in secondExpression.indices {
            if index.isMultiple(of: 2) { continue }
            
            guard let operation = secondExpression[index].mathOperator,
                  let secondNumber = secondExpression[index + 1].number else {
                fatalError("運算式內容有誤")
            }
            
            switch operation {
                case .divide, .multiply, .equal:
                    continue
                case .add:
                    sum += secondNumber
                case .subtract:
                    sum -= secondNumber
            }
        }
        
        // 3. 回傳運算結果
        return sum
    }
    
    mutating func saveCurrentValue() {
        if let mathOperator = MathOperator(rawValue: currentValue) {
            expression.append(.mathOperator(mathOperator))
        } else if let number = Decimal(string: currentValue) {
            expression.append(.number(number))
        } else {
            fatalError("無法轉換的資訊: \(currentValue)")
        }
        
        // 如果出現除數為 0 的情況要直接顯示「除數不得為零」。
        if
            expression.count >= 2,
            expression.last?.number == 0,
            expression[expression.count - 2].mathOperator == .divide {
            errorMessage = "除數不得為零"
        }
        
    }
    
}
