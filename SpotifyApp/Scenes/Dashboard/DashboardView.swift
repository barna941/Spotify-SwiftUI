import SwiftUI

struct DashboardView<Router: DashboardRouting>: View {
    let router: Router

    @State
    var currentTab = DashboardRoute.home
    private var tabs = DashboardRoute.allCases

    init(router: Router) {
        self.router = router
        configureTabBarAppearance()
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(
                selection: $currentTab,
                content: {
                    ForEach(tabs) { tab in
                        router.view(for: tab)
                            .tag(tab)
                    }
                }
            )

            ZStack(alignment: .bottom) {
                LinearGradient(
                    gradient: Gradient(colors: [Color.background, Color.background, Color.background, .clear]),
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

    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        UITabBar.appearance().standardAppearance = appearance
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(
            router: DashboardRouter(searchRouter: SearchRouter())
        )
    }
}
