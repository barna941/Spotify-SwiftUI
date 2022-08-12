import SwiftUI

struct AlbumDetailsView: View {
    private let imageWidthRatio: CGFloat = 0.65

    @StateObject
    var viewModel: AlbumDetailsViewModel

    @State
    private var yOffset: CGFloat = 0

    var body: some View {
        ColoredBackgroundView(hideBackButton: false) {
            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    Color(viewModel.headerColor)
                        .frame(height: imageWidth(geometry: geometry) + 16)
                        .edgesIgnoringSafeArea(.top)
                        .blur(radius: 32)

                    HStack {
                        Spacer()

                        AsyncImageView(url: viewModel.details.imageUrl?.asUrl)
                            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                            .frame(width: imageWidth(geometry: geometry))
                            .scaleEffect(scaleForImage(geometry: geometry), anchor: .center)
                            .opacity(alphaForImage(geometry: geometry))
                            .shadow(radius: 24)
                            .offset(x: .zero, y: offsetForImage(geometry: geometry))

                        Spacer()
                    }

                    OffsetObservableScrollView(
                        offsetChanged: { offset in
                            yOffset = offset.y
                        },
                        content: {
                            VStack(alignment: .leading) {
                                AlbumHeaderView(albumDetails: viewModel.details)

                                LazyVStack(alignment: .leading, spacing: .zero) {
                                    ForEach(viewModel.tracks) { track in
                                        AlbumDetailsTrackRow(
                                            artistName: viewModel.details.artistName,
                                            track: track
                                        )
                                        .padding([.top, .bottom], 4)
                                    }
                                }
                            }
                            .padding(.top, geometry.size.width * imageWidthRatio + 16)
                            .padding([.leading, .trailing], 16)
                        }
                    )
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Animation calculations

extension AlbumDetailsView {
    private func alphaForImage(geometry: GeometryProxy) -> CGFloat {
        let offset = -yOffset
        let fullImageHeight = imageWidth(geometry: geometry)
        let minValue = fullImageHeight * 0.5
        let maxValue = fullImageHeight
        let alpha = 1 - max(0, min(1, offset / (maxValue - minValue)))
        return alpha
    }

    private func scaleForImage(geometry: GeometryProxy) -> CGFloat {
        let offset = -yOffset
        let fullImageHeight = imageWidth(geometry: geometry)
        var ratio = (fullImageHeight - offset) / fullImageHeight
        if ratio > 1 {
            let diff = ratio - 1
            ratio = 1 + diff * (1 - diff)
        } else {
            let diff = 1 - ratio
            ratio = (diff + 1) * ratio
        }
        return ratio
    }

    private func offsetForImage(geometry: GeometryProxy) -> CGFloat {
        let scale = scaleForImage(geometry: geometry)
        let offset = (scale - 1) * 80
        return offset
    }

    private func imageWidth(geometry: GeometryProxy) -> CGFloat {
        geometry.size.width * imageWidthRatio
    }
}

struct AlbumDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailsView(
            viewModel: DependencyProvider.resolver.resolve(AlbumDetailsViewModel.self, argument: SearchModel.Album(
                id: "5l5m1hnH4punS1GQXgEi3T",
                artist: "TOOL",
                name: "Lateralus",
                releaseYear: "2001",
                imageUrl: "https://i.scdn.co/image/ab67616d00001e02ca41a947c13b78749c4953b1",
                albumType: "Album"
            ))!
        )
    }
}
