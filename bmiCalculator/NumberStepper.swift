import SwiftUI

struct NumberStepper: View {
    let title: String
    @Binding var value: Int
    let unit: String
    
    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.title2.bold())
            
            HStack(spacing: 8) {
                Button {
                    value -= 1
                } label: {
                    Image(systemName: "minus.square.fill")
                        .foregroundStyle(.brightGreen)
                }
                Text(value.formatted())
                    .bold()
                Button {
                    value += 1
                } label: {
                    Image(systemName: "plus.square.fill")
                        .foregroundStyle(.brightGreen)
                }
            }
            .font(.largeTitle)
            
            Text(unit)
                .font(.title2.bold())
        }
        .foregroundStyle(.white)
        .roundedBackground()
    }
}

#Preview {
    struct Preview: View {
        @State var weight = 10
        var body: some View {
            NumberStepper(title: "體重", value: $weight, unit: "公斤")
        }
    }
    
    return Preview()
}
