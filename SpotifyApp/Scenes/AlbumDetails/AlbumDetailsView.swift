import SwiftUI

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}

struct OffsetObservableScrollView<Content: View>: View {
    let axes: Axis.Set
    let showsIndicators: Bool
    let offsetChanged: (CGPoint) -> Void
    let content: Content
    private let coordinateSpaceName = "scrollView"

    init(
        axes: Axis.Set = .vertical,
        showsIndicators: Bool = true,
        offsetChanged: @escaping (CGPoint) -> Void = { _ in },
        @ViewBuilder content: () -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.offsetChanged = offsetChanged
        self.content = content()
    }

    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            GeometryReader { geometry in
                Color.clear.preference(
                    key: ScrollOffsetPreferenceKey.self,
                    value: geometry.frame(in: .named(coordinateSpaceName)).origin
                )
            }.frame(width: 0, height: 0)
            content
        }
        .coordinateSpace(name: coordinateSpaceName)
        .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offsetChanged)
    }
}

struct AlbumDetailsView: View {
    private let imageWidthRatio: CGFloat = 0.65

    @StateObject
    var viewModel: AlbumDetailsViewModel

    @State
    private var yOffset: CGFloat = 0

    private func scaleForImage(geometry: GeometryProxy) -> CGFloat {
        let fullImageHeight = imageWidth(geometry: geometry)
        let ratio = (fullImageHeight - (-yOffset)) / fullImageHeight
        return ratio
    }

    private func imageWidth(geometry: GeometryProxy) -> CGFloat {
        geometry.size.width * imageWidthRatio
    }

    var body: some View {
        ColoredBackgroundView(hideBackButton: false) {
            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    HStack {
                        Spacer()

                        AsyncImageView(url: viewModel.details.imageUrl?.asUrl)
                            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                            .frame(width: imageWidth(geometry: geometry))
                            .scaleEffect(scaleForImage(geometry: geometry), anchor: .center)
                            .opacity(scaleForImage(geometry: geometry))

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
