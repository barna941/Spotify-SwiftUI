import Foundation

protocol DashboardSceneFactoryProtocol {
    func createDashboardCoordinatorView(tabs: [DashboardRoute]) -> DashboardCoordinatorView
}

struct DashboardSceneFactory: DashboardSceneFactoryProtocol {
    func createDashboardCoordinatorView(tabs: [DashboardRoute]) -> DashboardCoordinatorView {
        DashboardCoordinatorView(
            coordinator: DependencyProvider.resolver.resolve(DashboardCoordinator.self)!,
            tabs: tabs
        )
    }
}
