import SwiftUI

final class DashboardCoordinator: ObservableObject {

    private let homeSceneFactory: HomeSceneFactoryProtocol
    private let searchSceneFactory: SearchSceneFactoryProtocol
    private let librarySceneFactory: LibrarySceneFactoryProtocol

    init(
        homeSceneFactory: HomeSceneFactoryProtocol,
        searchSceneFactory: SearchSceneFactoryProtocol,
        librarySceneFactory: LibrarySceneFactoryProtocol
    ) {
        self.homeSceneFactory = homeSceneFactory
        self.searchSceneFactory = searchSceneFactory
        self.librarySceneFactory = librarySceneFactory
    }

    @ViewBuilder
    func view(for route: DashboardRoute) -> some View {
        switch route {
        case .home:
            homeSceneFactory.createHomeView()
        case .search:
            searchSceneFactory.createSearchCoordinatorView()
        case .library:
            librarySceneFactory.createLibraryView()
        }
    }
}
