import Combine
import Foundation

final class SearchViewModel: ObservableObject {

    private let interactor: SearchInteractorProtocol
    private var cancellables = Set<AnyCancellable>()

    @Published
    var searchText: String = ""
    @Published
    var searchResults = SearchModel.Result()
    @Published
    var activeNavigation: SearchRoute?

    var searchTypes: [SearchModel.SearchType] {
        SearchModel.SearchType.allCases
    }

    init(interactor: SearchInteractorProtocol) {
        self.interactor = interactor

        bindSearch()
        bindNavigation()
    }

    private func bindSearch() {
        let sharedSearchTextPublisher = $searchText.share()
        sharedSearchTextPublisher
            .filter { $0.count > 2 }
            .debounce(for: .milliseconds(750), scheduler: DispatchQueue.main)
            .flatMap { searchText in
                self.interactor.search(for: searchText)
            }
            .map { searchResponseDto -> SearchModel.Result in
                self.resultModel(from: searchResponseDto)
            }
            .replaceError(with: SearchModel.Result())
            .assign(to: \.searchResults, on: self)
            .store(in: &cancellables)

        sharedSearchTextPublisher
            .filter { $0.isEmpty }
            .map { _ in SearchModel.Result() }
            .assign(to: \.searchResults, on: self)
            .store(in: &cancellables)
    }

    private func bindNavigation() {
    }

    // MARK: - Model mapping

    private func resultModel(from searchResponseDto: SearchResponseDTO) -> SearchModel.Result {
        SearchModel.Result(
            artists: searchResponseDto.artists.items.map { artistFrom(dto: $0) },
            albums: searchResponseDto.albums.items.map { albumFrom(dto: $0) },
            tracks: searchResponseDto.tracks.items.map { trackFrom(dto: $0) },
            playlists: searchResponseDto.playlists.items.map { playlistFrom(dto: $0) }
        )
    }

    private func artistFrom(dto: ArtistDTO) -> SearchModel.Artist {
        SearchModel.Artist(id: dto.id, name: dto.name, imageUrl: dto.images?.first?.url)
    }

    private func albumFrom(dto: AlbumDTO) -> SearchModel.Album {
        SearchModel.Album(
            id: dto.id,
            artist: dto.artists.first?.name ?? "",
            name: dto.name,
            releaseYear: year(from: dto.releaseDate),
            imageUrl: dto.images?.first?.url
        )
    }

    private func trackFrom(dto: TrackDTO) -> SearchModel.Track {
        SearchModel.Track(
            id: dto.id,
            name: dto.name,
            artist: dto.artists.first?.name ?? "",
            imageUrl: dto.images?.first?.url
        )
    }

    private func playlistFrom(dto: PlaylistDTO) -> SearchModel.Playlist {
        SearchModel.Playlist(
            id: dto.id,
            name: dto.name,
            imageUrl: dto.images?.first?.url
        )
    }

    private func year(from releaseDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: releaseDate) else {
            return ""
        }
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
}
