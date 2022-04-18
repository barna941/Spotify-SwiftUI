import SwiftUI

struct AlbumResultGridItem: View {
    let album: SearchModel.Album
    
    var body: some View {
        VStack(alignment: .leading) {
            if let imageUrl = album.imageUrl?.asUrl {
                AsyncImageView(url: imageUrl)
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
            } else {
                Image(systemName: "music.mic.circle.fill")
                    .resizable()
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                    .foregroundColor(Color.textPrimary)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(album.name)
                    .font(.body.bold())
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.textPrimary)

                Text(album.artist)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.textSecondary)

                Text(album.releaseYear)
                    .font(.body)
                    .foregroundColor(.textSecondary)
            }
        }
        .padding(8)
    }
}

struct AlbumResultGridItem_Previews: PreviewProvider {
    static var previews: some View {
        AlbumResultGridItem(
            album: SearchModel.Album(
                id: "5l5m1hnH4punS1GQXgEi3T",
                artist: "TOOL",
                name: "Lateralus",
                releaseYear: "2001",
                imageUrl: "https://i.scdn.co/image/ab67616d00001e02ca41a947c13b78749c4953b1"
            )
        )
        .background(Color.background)
    }
}
