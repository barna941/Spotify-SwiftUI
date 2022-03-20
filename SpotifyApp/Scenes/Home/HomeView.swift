import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            Text("Home view")
                .foregroundColor(.textPrimary)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
