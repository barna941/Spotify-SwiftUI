import SwiftUI

struct LibraryView: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            Text("Library view")
                .foregroundColor(.textPrimary)
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
