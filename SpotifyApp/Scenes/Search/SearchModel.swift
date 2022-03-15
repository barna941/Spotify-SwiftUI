import Foundation

enum SearchModel {
    struct Result {
        let artists: [Artist]
        let albums: [Album]
        let tracks: [Track]
        let playlists: [Playlist]

        init(artists: [Artist] = [], albums: [Album] = [], tracks: [Track] = [], playlists: [Playlist] = []) {
            self.artists = artists
            self.albums = albums
            self.tracks = tracks
            self.playlists = playlists
        }
    }

    enum SearchType: String, Identifiable, CaseIterable, Hashable {
        case artist
        case album
        case track
        case playlist

        var id: String { rawValue }
        var name: String { rawValue }
    }
}

extension SearchModel {
    struct Artist: Identifiable {
        let id: String
        let name: String
        let imageUrl: String?
    }
}

extension SearchModel {
    struct Album: Identifiable {
        let id: String
        let artist: String
        let name: String
        let releaseYear: String
        let imageUrl: String?
    }
}

extension SearchModel {
    struct Track: Identifiable {
        let id: String
        let name: String
        let artist: String
        let imageUrl: String?
    }
}

extension SearchModel {
    struct Playlist: Identifiable {
        let id: String
        let name: String
        let imageUrl: String?
    }
}

extension String {
    var asUrl: URL? { URL(string: self) }
}
