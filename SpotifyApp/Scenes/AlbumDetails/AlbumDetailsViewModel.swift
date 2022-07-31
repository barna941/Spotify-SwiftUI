import Combine

final class AlbumDetailsViewModel: ObservableObject {
    private let album: SearchModel.Album
    private let interactor: AlbumDetailsInteractorProtocol
    private var cancellables = Set<AnyCancellable>()

    @Published
    var tracks = [AlbumModel.Track]()
    @Published
    var details = AlbumModel.Details(artistName: "", albumName: "", imageUrl: nil, year: "", albumType: "")

    init(album: SearchModel.Album, interactor: AlbumDetailsInteractorProtocol) {
        self.album = album
        self.interactor = interactor

        details = AlbumModel.Details(
            artistName: album.artist,
            albumName: album.name,
            imageUrl: album.imageUrl,
            year: album.releaseYear,
            albumType: album.albumType.capitalized
        )
        bindAlbumTracksFetch()
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
}
