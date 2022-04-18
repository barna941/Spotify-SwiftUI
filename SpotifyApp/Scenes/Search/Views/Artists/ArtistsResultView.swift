import SwiftUI
import Combine

struct ArtistsResultView: View {
    let topInset: CGFloat

    @Binding
    var artists: [SearchModel.Artist]
    let didSelectArtist: ((SearchModel.Artist) -> Void)?

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: .zero) {
                ForEach(artists) { artist in
                    Button(
                        action: {
                            didSelectArtist?(artist)
                        },
                        label: {
                            ArtistResultRow(artist: artist)
                        }
                    )
                }
            }
            .padding(.top, topInset)
        }
    }
}

struct ArtistsResultView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.background.ignoresSafeArea()

            ArtistsResultView(
                topInset: 0,
                artists: .constant([
                    SearchModel.Artist(
                        id: "1",
                        name: "Red Hot Chili Peppers",
                        imageUrl: "https://i.scdn.co/image/ab6761610000f178b0dd96d5c6fcd8b068834373"
                    ),
                    SearchModel.Artist(
                        id: "2",
                        name: "TOOL",
                        imageUrl: "https://i.scdn.co/image/ab6761610000f17813f5472b709101616c87cba3"
                    )
                ]),
                didSelectArtist: nil
            )
        }
    }
}
