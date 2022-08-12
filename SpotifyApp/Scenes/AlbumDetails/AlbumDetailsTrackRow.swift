import SwiftUI

struct AlbumDetailsTrackRow: View {
    let artistName: String
    let track: AlbumModel.Track

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(track.name)
                    .foregroundColor(Color.textPrimary)
                    .font(.body.bold())

                Text(artistName)
                    .foregroundColor(Color.textSecondary)
                    .font(.footnote)
            }

            Spacer()

            Image(systemName: "ellipsis")
                .foregroundColor(Color.textSecondary)
        }
        .padding([.top, .bottom], 8)
    }
}

struct AlbumDetailsTrackRow_Previews: PreviewProvider {
    static var previews: some View {
        ColoredBackgroundView {
            AlbumDetailsTrackRow(
                artistName: "Rammstein",
                track: AlbumModel.Track(
                    id: "abc123",
                    trackNumber: 1,
                    durationInSeconds: 330,
                    name: "Zeit"
                )
            )
        }
    }
}
