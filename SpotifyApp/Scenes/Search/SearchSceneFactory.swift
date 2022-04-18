import Foundation

protocol SearchSceneFactoryProtocol {
    func createSearchCoordinatorView() -> SearchCoordinatorView
    func createSearchView(coordinator: SearchCoordinator) -> SearchView
    func createArtistDetailsView(artist: SearchModel.Artist) -> ArtistDetailsView
}

struct SearchSceneFactory: SearchSceneFactoryProtocol {
    func createSearchCoordinatorView() -> SearchCoordinatorView {
        SearchCoordinatorView(coordinator: DependencyProvider.resolver.resolve(SearchCoordinator.self)!)
    }
    func createSearchView(coordinator: SearchCoordinator) -> SearchView {
        SearchView(
            viewModel: DependencyProvider.resolver.resolve(SearchViewModel.self, argument: coordinator)!
        )
    }
    func createArtistDetailsView(artist: SearchModel.Artist) -> ArtistDetailsView {
        ArtistDetailsView(artist: artist)
    }
}
