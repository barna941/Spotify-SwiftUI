import Foundation

struct SearchResponseDTO: Decodable {
    let artists: SearchItemDTO<ArtistDTO>
    let albums: SearchItemDTO<AlbumDTO>
    let tracks: SearchItemDTO<TrackDTO>
    let playlists: SearchItemDTO<PlaylistDTO>
}

struct SearchItemDTO<Item: Decodable>: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let items: [Item]
}

struct ArtistDTO: Decodable {
    let id: String
    let genres: [String]?
    let images: [ImageDTO]?
    let name: String
    let popularity: Int?
    let type: SearchRequestDTO.SearchType
}

struct AlbumDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case totalTracks = "total_tracks"
        case artists
        case images
        case name
        case releaseDate = "release_date"
    }

    let id: String
    let totalTracks: Int
    let artists: [ArtistDTO]
    let images: [ImageDTO]?
    let name: String
    let releaseDate: String
}

struct TrackDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case artists
        case album
        case releaseDate = "release_date"
    }

    let id: String
    let name: String
    let artists: [ArtistDTO]
    let album: AlbumDTO?
    let releaseDate: String?
}

struct PlaylistDTO: Decodable {
    let id: String
    let name: String
    let images: [ImageDTO]?
}

struct ImageDTO: Decodable {
    let url: String
    let width: Int?
    let height: Int?
}
