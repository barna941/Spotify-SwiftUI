import SwiftUI

struct SearchView: View {

    @StateObject
    var viewModel: SearchViewModel

    private let topInset: CGFloat = 104

    var body: some View {
        ZStack(alignment: .top) {
            Color.background.ignoresSafeArea()

            SearchResultsView(
                topInset: topInset,
                selectedResultType: $viewModel.selectedResultType,
                searchResults: $viewModel.searchResults,
                didSelectArtist: { artist in
                    viewModel.didSelectArtist(artist: artist)
                },
                didSelectAlbum: { album in
                    viewModel.didSelectAlbum(album: album)
                },
                didSelectPlaylist: { playlist in
                    print(playlist)
                }
            )

            VisualEffectView(effect: UIBlurEffect(style: .dark))
                .ignoresSafeArea()
                .frame(height: topInset)

            VStack {
                SearchTextFieldView(searchText: $viewModel.searchText)
                SearchResultSelectorView(
                    searchTypes: viewModel.searchTypes,
                    selectedType: $viewModel.selectedResultType
                )
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(
            viewModel: SearchViewModel(
                interactor: DependencyProvider.resolver.resolve(SearchInteractorProtocol.self)!,
                coordinator: DependencyProvider.resolver.resolve(SearchCoordinatorProtocol.self)!
            )
        )
    }
}
