import SwiftUI

enum AppRoute {
    case initial
}

struct AppRouter<DashboardRouter: DashboardRouting>: Routing {

    private let dashboardRouter: DashboardRouter

    init(dashboardRouter: DashboardRouter) {
        self.dashboardRouter = dashboardRouter
    }

    func view(for route: AppRoute) -> some View {
        switch route {
        case .initial:
            dashboardRouter.dashboardView()
        }
    }
}
