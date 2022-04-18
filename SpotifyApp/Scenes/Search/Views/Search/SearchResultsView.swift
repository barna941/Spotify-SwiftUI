import SwiftUI

struct SearchResultsView: View {
    let topInset: CGFloat

    @Binding
    var selectedResultType: SearchModel.SearchType
    @Binding
    var searchResults: SearchModel.Result

    let didSelectArtist: ((SearchModel.Artist) -> Void)?

    var body: some View {
        switch selectedResultType {
        case .artist:
            ArtistsResultView(
                topInset: topInset,
                artists: Binding(get: { searchResults.artists }),
                didSelectArtist: { artist in
                    didSelectArtist?(artist)
                }
            )

        case .album:
            AlbumResultView(
                topInset: topInset,
                albums: Binding(get: { searchResults.albums }),
                didSelectAlbum: { album in
                    print(album)
                }
            )

        case .track:
            AlbumResultView(
                topInset: topInset,
                albums: Binding(get: { searchResults.albums }),
                didSelectAlbum: { album in
                    print(album)
                }
            )

        case .playlist:
            AlbumResultView(
                topInset: topInset,
                albums: Binding(get: { searchResults.albums }),
                didSelectAlbum: { album in
                    print(album)
                }
            )
        }
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            SearchResultsView(
                topInset: 0,
                selectedResultType: .constant(.artist),
                searchResults: .constant(SearchModel.Result()),
                didSelectArtist: nil
            )
        }
    }
}
