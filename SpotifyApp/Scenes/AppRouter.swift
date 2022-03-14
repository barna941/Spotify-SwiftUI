import SwiftUI

enum AppRoute {
    case initial
}

struct AppRouter: Routing {

    private let searchRouter = SearchRouter()

    func view(for route: AppRoute) -> some View {
        switch route {
        case .initial:
            searchRouter.view(for: .search)
        }
    }
}
