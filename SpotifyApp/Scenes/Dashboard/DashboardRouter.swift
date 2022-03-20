import SwiftUI

enum DashboardRoute: String, CaseIterable, Hashable, TabBarButtonRepresentable {
    case home
    case search
    case library

    var id: String { rawValue }
    var name: String { rawValue.capitalized }

    var imageName: String {
        switch self {
        case .home:
            return "house"
        case .search:
            return "magnifyingglass"
        case .library:
            return "books.vertical"
        }
    }

    var selectedImageName: String {
        switch self {
        case .home:
            return "house.fill"
        case .search:
            return "sparkle.magnifyingglass"
        case .library:
            return "books.vertical.fill"
        }
    }
}

protocol DashboardRouting: Routing where Route == DashboardRoute {
    associatedtype Dashboard: View

    @ViewBuilder func dashboardView() -> Dashboard
}

struct DashboardRouter: DashboardRouting {

    private let searchRouter: SearchRouter

    init(searchRouter: SearchRouter) {
        self.searchRouter = searchRouter
    }

    func dashboardView() -> some View {
        DashboardView(router: self)
    }

    @ViewBuilder
    func view(for route: DashboardRoute) -> some View {
        switch route {
        case .home:
            HomeView()

        case .search:
            searchRouter.view(for: .search)

        case .library:
            LibraryView()
        }
    }
}
