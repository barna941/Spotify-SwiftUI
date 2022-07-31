import Foundation

typealias AlbumTracksResponseDTO = BaseItemDTO<AlbumTracksDTO>

struct AlbumTracksDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case trackNumber = "track_number"
        case durationInMillisec = "duration_ms"
        case name
    }

    let id: String
    let trackNumber: Int
    let durationInMillisec: Int
    let name: String
}
