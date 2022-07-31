import SwiftUI

struct AlbumHeaderView: View {
    let albumDetails: AlbumModel.Details

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(albumDetails.albumName)
                .foregroundColor(.textPrimary)
                .font(.title.bold())

            HStack {
                Image(systemName: "music.mic.circle")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.white)

                Text(albumDetails.artistName)
                    .foregroundColor(.textPrimary)
                    .font(.callout.bold())
            }

            HStack {
                Text(albumDetails.albumType)
                    .foregroundColor(.textSecondary)
                    .font(.subheadline)

                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 4, height: 4)
                    .foregroundColor(.textSecondary)

                Text(albumDetails.year)
                    .foregroundColor(.textSecondary)
                    .font(.subheadline)
            }

            HStack(spacing: 32) {
                Button(
                    action: {},
                    label: {
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 32, height: 28)
                            .foregroundColor(.textSecondary)
                    }
                )

                Button(
                    action: {},
                    label: {
                        Image(systemName: "arrow.down.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.textSecondary)
                    }
                )

                Button(
                    action: {},
                    label: {
                        Image(systemName: "ellipsis")
                            .frame(width: 30, height: 30)
                            .foregroundColor(.textSecondary)
                    }
                )
            }
            .padding([.top, .bottom], 8)
        }
    }
}


struct AlbumHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ColoredBackgroundView {
            AlbumHeaderView(
                albumDetails: AlbumModel.Details(
                    artistName: "Red Hot Chili Peppers",
                    albumName: "Unlimited Love",
                    imageUrl: "https://i.scdn.co/image/ab67616d0000b27397a52e0aeda9d95fb881c56d",
                    year: "2022",
                    albumType: "Album"
                )
            )
        }
    }
}
