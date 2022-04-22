import SwiftUI

struct AlbumDetailsView: View {
    let album: SearchModel.Album

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            Text("Album: \(album.name)")
                .foregroundColor(.textPrimary)
        }
    }
}

struct AlbumDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailsView(
            album: SearchModel.Album(
                id: "5l5m1hnH4punS1GQXgEi3T",
                artist: "TOOL",
                name: "Lateralus",
                releaseYear: "2001",
                imageUrl: "https://i.scdn.co/image/ab67616d00001e02ca41a947c13b78749c4953b1"
            )
        )
    }
}
