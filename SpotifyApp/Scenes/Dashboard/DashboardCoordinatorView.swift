import SwiftUI

struct DashboardCoordinatorView: View {

    @ObservedObject
    var coordinator: DashboardCoordinator

    @State
    private var currentTab: DashboardRoute
    private let tabs: [DashboardRoute]

    init(coordinator: DashboardCoordinator, tabs: [DashboardRoute]) {
        self.coordinator = coordinator
        self.tabs = tabs
        self.currentTab = tabs.first ?? .home

        configureTabBarAppearance()
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(
                selection: $currentTab,
                content: {
                    ForEach(tabs) { tab in
                        coordinator.view(for: tab)
                            .tag(tab)
                    }
                }
            )

            BottomTabBarView(currentTab: $currentTab, tabs: tabs)
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
        DashboardCoordinatorView(
            coordinator: DependencyProvider.resolver.resolve(DashboardCoordinator.self)!,
            tabs: DashboardRoute.allCases
        )
    }
}
