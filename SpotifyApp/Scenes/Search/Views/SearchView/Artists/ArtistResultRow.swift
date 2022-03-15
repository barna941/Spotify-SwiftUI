import SwiftUI

struct ArtistResultRow: View {
    let artist: SearchModel.Artist

    var body: some View {
        HStack {
            if let imageUrl = artist.imageUrl?.asUrl {
                AsyncImageView(url: imageUrl)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            } else {
                Image(systemName: "music.mic.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.textPrimary)
            }

            Text(artist.name)
                .foregroundColor(Color.textPrimary)
                .font(.title3)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(Color.textPrimary)
        }
        .padding()
    }
}

struct ArtistResultRow_Previews: PreviewProvider {
    static var previews: some View {
        ArtistResultRow(
            artist: SearchModel.Artist(
                id: "2",
                name: "TOOL",
                imageUrl: "https://i.scdn.co/image/ab6761610000f17813f5472b709101616c87cba3"
            )
        )
        .background(Color.background)
    }
}
