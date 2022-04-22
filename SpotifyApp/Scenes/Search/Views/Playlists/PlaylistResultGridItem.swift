import SwiftUI

struct PlaylistResultGridItem: View {
    let playlist: SearchModel.Playlist

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageUrl = playlist.imageUrl?.asUrl {
                AsyncImageView(url: imageUrl)
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
            } else {
                Image(systemName: "music.mic.circle.fill")
                    .resizable()
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                    .foregroundColor(Color.textPrimary)
            }

            Text(playlist.name)
                .font(.body.bold())
                .multilineTextAlignment(.leading)
                .foregroundColor(.textPrimary)
        }
        .padding(8)
    }
}

struct PlaylistResultGridItem_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistResultGridItem(
            playlist: SearchModel.Playlist(
                id: "37i9dQZF1DZ06evO1sZyol",
                name: "This Is TOOL",
                imageUrl: "https://thisis-images.scdn.co/37i9dQZF1DZ06evO1sZyol-large.jpg"
            )
        )
        .background(Color.background)
    }
}
