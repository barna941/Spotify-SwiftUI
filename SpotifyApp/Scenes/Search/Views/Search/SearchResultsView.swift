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
            AlbumsResultView()

        case .track:
            AlbumsResultView()

        case .playlist:
            AlbumsResultView()
        }
    }
}

struct AlbumsResultView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<100) { item in
                    Image(systemName: "music.quarternote.3")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .foregroundColor(Color.textPrimary)
                }
            }
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
