import SwiftUI

enum SearchRoute: Hashable {
    case search
    case artistDetails(SearchModel.Artist)
    case albumDetails(SearchModel.Album)
}

protocol SearchCoordinatorProtocol {
    var currentRoute: SearchRoute? { get set }
}

final class SearchCoordinator: SearchCoordinatorProtocol, ObservableObject {
    private let sceneFactory: SearchSceneFactoryProtocol

    @Published
    var currentRoute: SearchRoute?

    init(sceneFactory: SearchSceneFactoryProtocol) {
        self.sceneFactory = sceneFactory
    }

    @ViewBuilder
    func view(for route: SearchRoute) -> some View {
        switch route {
        case .search:
            sceneFactory.createSearchView(coordinator: self)
        case let .artistDetails(artist):
            sceneFactory.createArtistDetailsView(artist: artist)
        case let .albumDetails(album):
            sceneFactory.createAlbumDetailsView(album: album)
        }
    }
}
