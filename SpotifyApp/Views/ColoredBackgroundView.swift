import SwiftUI

struct ColoredBackgroundView<Content: View>: View {
    var color = Color.background
    var hideBackButton = true

    @ViewBuilder
    let content: (() -> Content)

    var body: some View {
        ZStack {
            color.ignoresSafeArea()
            content()
        }
        .navigationBarBackButtonHidden(hideBackButton)
    }
}
