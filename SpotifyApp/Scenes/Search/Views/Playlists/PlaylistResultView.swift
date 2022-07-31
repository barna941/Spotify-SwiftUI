import SwiftUI

struct PlaylistResultView: View {
    let topInset: CGFloat

    @Binding
    var playlists: [SearchModel.Playlist]
    let didSelectPlaylist: ((SearchModel.Playlist) -> Void)?

    private let columns = [
        GridItem(.flexible(), alignment: .top),
        GridItem(.flexible(), alignment: .top)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 16,
                content: {
                    ForEach(playlists) { playlist in
                        Button(
                            action: {
                                didSelectPlaylist?(playlist)
                            },
                            label: {
                                PlaylistResultGridItem(playlist: playlist)
                            }
                        )
                    }
                }
            )
            .padding(.top, topInset)
            .padding([.leading, .trailing], 8)
        }
    }
}

struct PlaylistResultView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistResultView(
            topInset: 0,
            playlists: .constant([
                SearchModel.Playlist(
                    id: "37i9dQZF1DZ06evO1sZyola",
                    name: "This Is TOOL",
                    imageUrl: "https://thisis-images.scdn.co/37i9dQZF1DZ06evO1sZyol-large.jpg"
                ),
                SearchModel.Playlist(
                    id: "37i9dQZF1DZ06evO1sZyolb",
                    name: "This Is TOOL",
                    imageUrl: "https://thisis-images.scdn.co/37i9dQZF1DZ06evO1sZyol-large.jpg"
                ),
                SearchModel.Playlist(
                    id: "37i9dQZF1DZ06evO1sZyolc",
                    name: "This Is TOOL",
                    imageUrl: "https://thisis-images.scdn.co/37i9dQZF1DZ06evO1sZyol-large.jpg"
                )
            ]),
            didSelectPlaylist: nil
        )
        .background(Color.background)
    }
}
