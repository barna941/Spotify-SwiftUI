import Foundation

struct SearchResponseDTO: Decodable {
    let artists: BaseItemDTO<ArtistDTO>
    let albums: BaseItemDTO<AlbumDTO>
    let tracks: BaseItemDTO<TrackDTO>
    let playlists: BaseItemDTO<PlaylistDTO>
}

struct BaseItemDTO<Item: Decodable>: Decodable {
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
        case albumType = "album_type"
    }

    let id: String
    let totalTracks: Int
    let artists: [ArtistDTO]
    let images: [ImageDTO]?
    let name: String
    let releaseDate: String
    let albumType: String
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
