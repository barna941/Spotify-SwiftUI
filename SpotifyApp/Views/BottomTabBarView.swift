import SwiftUI

struct BottomTabBarView: View {
    @Binding
    var currentTab: DashboardRoute
    let tabs: [DashboardRoute]

    var body: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(
                gradient: Gradient(colors: [Color.background, Color.background, Color.background, Color.clear]),
                startPoint: .bottom,
                endPoint: .top
            ).ignoresSafeArea()

            HStack {
                ForEach(tabs) { tab in
                    TabBarButton(tab: tab, selectedTab: $currentTab)
                }
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}
