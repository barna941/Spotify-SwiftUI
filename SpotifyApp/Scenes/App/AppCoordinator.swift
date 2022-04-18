import SwiftUI

enum AppRoute {
    case onboarding
    case dashboard
}

final class AppCoordinator: ObservableObject {

    private let dashboardSceneFactory: DashboardSceneFactoryProtocol

    init(dashboardSceneFactory: DashboardSceneFactoryProtocol) {
        self.dashboardSceneFactory = dashboardSceneFactory
    }

    @ViewBuilder
    func view(for route: AppRoute) -> some View {
        switch route {
        case .onboarding:
            dashboardSceneFactory.createDashboardCoordinatorView(tabs: DashboardRoute.allCases)
        case .dashboard:
            dashboardSceneFactory.createDashboardCoordinatorView(tabs: DashboardRoute.allCases)
        }
    }
}
