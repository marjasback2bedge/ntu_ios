//
//  BMIView.swift
//  Calculator
//
//  Created by Jane Chao on 2024/4/17.
//

import SwiftUI

struct BMIView: View {
    @State var height: Double = 160
    @State var age: Int = 25
    @State var weight: Int = 60
    @State var gender: Gender = .female
    @State var shouldShowBMI: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            Label("BMI 計算機", systemImage: "figure.mind.and.body")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title3.bold())
            
            HStack(spacing: 16) {
                GenderButton(gender: .female, selectedGender: $gender)
                
                GenderButton(gender: .male, selectedGender: $gender)
            }
            
            VStack(spacing: 16) {
                Text("身高")
                    .font(.title2.bold())
                
                Text(height.formatted() + "公分")
                    .font(.largeTitle.bold())
                
                Slider(value: $height, in: 80...200, step: 1)
            }.roundedBackground()
            
            HStack(spacing: 16) {
                NumberStepper(title: "體重", value: $weight, unit: "公斤")
                
                NumberStepper(title: "年紀", value: $age, unit: "歲")
            }
            
            Button {
                shouldShowBMI = true
            } label: {
                Text("計算")
                    .foregroundStyle(.black)
                    .font(.largeTitle.bold())
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .background(.brightGreen, in: .rect(cornerRadius: 16))
            }
        }
        .foregroundStyle(.white)
        .padding(.horizontal)
        .background(.black)
        .alert("您的 BMI 為 \(bmi.formatted(.number.precision(.fractionLength(1))))，\(review)。", isPresented: $shouldShowBMI) {
            Button("OK") {}
        }
    }
    
    var bmi: Double {
        // 體重（公斤）／身高平方（平方公尺）
        Double(weight) / (height / 100 * height / 100)
    }
    
    var review: String {
        switch bmi {
            case ..<18.5: "過輕"
            case ..<24: "正常"
            default: "過重"
        }
    }
}

#Preview {
    BMIView()
}
