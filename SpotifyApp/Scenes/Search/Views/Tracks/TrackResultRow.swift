import SwiftUI

struct TrackResultRow: View {
    let track: SearchModel.Track

    var body: some View {
        HStack {
            if let imageUrl = track.imageUrl?.asUrl {
                AsyncImageView(url: imageUrl)
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
            } else {
                Image(systemName: "music.mic.circle.fill")
                    .resizable()
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                    .foregroundColor(Color.textPrimary)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(track.name)
                    .foregroundColor(Color.textPrimary)
                    .font(.body.bold())

                Text(track.artist)
                    .foregroundColor(Color.textSecondary)
                    .font(.body)
            }
            .padding(.leading, 8)

            Spacer()

            Image(systemName: "ellipsis")
                .foregroundColor(Color.textSecondary)
        }
        .padding(12)
    }
}

struct TrackResultRow_Previews: PreviewProvider {
    static var previews: some View {
        TrackResultRow(
            track: SearchModel.Track(
                id: "6deiaArbeoqp1xPEGdEKp1",
                name: "Can't Stop",
                artist: "Red Hot Chili Peppers",
                imageUrl: "https://i.scdn.co/image/ab67616d00001e02de1af2785a83cc660155a0c4"
            )
        )
        .background(Color.background)
    }
}
