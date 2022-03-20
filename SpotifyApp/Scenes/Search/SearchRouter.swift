import SwiftUI

enum SearchRoute {
    case search
    case artistDetails
    case albumDetails
}

protocol SearchRouting: Routing where Route == SearchRoute {}

struct SearchRouter: SearchRouting {
    func view(for route: SearchRoute) -> some View {
        switch route {
        case .search:
            SearchView(
                router: self,
                viewModel: DependencyProvider.resolver.resolve(SearchViewModel.self)!
            )

        case .artistDetails:
            ArtistDetailsView()

        case .albumDetails:
            ArtistDetailsView()
        }
    }
}
