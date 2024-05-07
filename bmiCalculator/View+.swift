import SwiftUI

extension View {
    func roundedBackground() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.grayBackground, in: .rect(cornerRadius: 16))
    }
}
