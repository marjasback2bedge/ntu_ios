import SwiftUI

struct GenderButton: View {
    let gender: Gender
    @Binding var selectedGender: Gender
    
    var isSelected: Bool {
        gender == selectedGender
    }
    
    var body: some View {
        Button {
            selectedGender = gender
        } label: {
            VStack {
                Text(gender.symbol)
                    .font(.system(size: 80))
                    .foregroundStyle(.brightGreen)
                Text(gender.description)
                    .font(.title2.bold())
                    .foregroundStyle(.white)
            }
            .roundedBackground()
        }
        .buttonStyle(.plain)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: isSelected ? 3 : 0)
                .foregroundStyle(.brightGreen.opacity(0.8))
        }
    }
}

#Preview {
    struct Preview: View {
        @State var state = Gender.female
        var body: some View {
            HStack {
                GenderButton(gender: .female, selectedGender: $state)
                GenderButton(gender: .male, selectedGender: $state)
            }
            .frame(height: 200)
        }
    }
    
    return Preview()
}
