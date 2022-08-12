import Combine
import UIKit

final class AlbumDetailsViewModel: ObservableObject {
    private let album: SearchModel.Album
    private let interactor: AlbumDetailsInteractorProtocol
    private let imageLoader: ImageLoader
    private var cancellables = Set<AnyCancellable>()

    @Published
    var tracks = [AlbumModel.Track]()
    @Published
    var details = AlbumModel.Details(artistName: "", albumName: "", imageUrl: nil, year: "", albumType: "")
    @Published
    var headerColor: UIColor = .clear

    init(album: SearchModel.Album, interactor: AlbumDetailsInteractorProtocol, imageLoader: ImageLoader) {
        self.album = album
        self.interactor = interactor
        self.imageLoader = imageLoader

        details = AlbumModel.Details(
            artistName: album.artist,
            albumName: album.name,
            imageUrl: album.imageUrl,
            year: album.releaseYear,
            albumType: album.albumType.capitalized
        )

        bindAlbumTracksFetch()
        bindImageLoad()
        loadImageIfNeeded()
    }

    private func bindAlbumTracksFetch() {
        interactor
            .tracks(for: album.id)
            .map { dto -> [AlbumModel.Track] in
                dto.items.map {
                    AlbumModel.Track(
                        id: $0.id,
                        trackNumber: $0.trackNumber,
                        durationInSeconds: $0.durationInMillisec / 1000,
                        name: $0.name
                    )
                }
            }
            .replaceError(with: [])
            .assign(to: \.tracks, on: self)
            .store(in: &cancellables)
    }

    private func bindImageLoad() {
        imageLoader.$image
            .compactMap { $0?.averageColor }
            .assign(to: \.headerColor, on: self)
            .store(in: &cancellables)
    }

    private func loadImageIfNeeded() {
        guard let imageUrl = album.imageUrl, let url = URL(string: imageUrl) else { return }
        imageLoader.loadImage(from: url)
    }
}
