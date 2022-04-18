import SwiftUI

struct AlbumResultView: View {
    let topInset: CGFloat

    @Binding
    var albums: [SearchModel.Album]
    let didSelectAlbum: ((SearchModel.Album) -> Void)?

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
                    ForEach(albums) { album in
                        Button(
                            action: {
                                didSelectAlbum?(album)
                            },
                            label: {
                                AlbumResultGridItem(album: album)
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

struct AlbumResultView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.background.ignoresSafeArea()

            AlbumResultView(
                topInset: 0,
                albums: .constant([
                    SearchModel.Album(
                        id: "5l5m1hnH4punS1GQXgEi3T",
                        artist: "TOOL",
                        name: "Lateralus",
                        releaseYear: "2001",
                        imageUrl: "https://i.scdn.co/image/ab67616d00001e02ca41a947c13b78749c4953b1"
                    ),
                    SearchModel.Album(
                        id: "5l5m1hnH4punS1GQXgEi3asdasdasd",
                        artist: "TOOL",
                        name: "Fear Inoculum asd asd asd asd asd",
                        releaseYear: "2019",
                        imageUrl: "https://i.scdn.co/image/ab67616d00001e0226e6b6f666ef40b6b8365e3e"
                    ),
                    SearchModel.Album(
                        id: "5l5m1hnH4punS1GQXgEi3qweqweqwe",
                        artist: "TOOL",
                        name: "Fear Inoculum",
                        releaseYear: "2019",
                        imageUrl: "https://i.scdn.co/image/ab67616d00001e0226e6b6f666ef40b6b8365e3e"
                    )
                ]),
                didSelectAlbum: nil
            )
        }
    }
}
