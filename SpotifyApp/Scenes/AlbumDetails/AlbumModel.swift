import Foundation

struct AlbumModel {
    struct Details {
        let artistName: String
        let albumName: String
        let imageUrl: String?
        let year: String
        let albumType: String
    }

    struct Track: Identifiable {
        let id: String
        let trackNumber: Int
        let durationInSeconds: Int
        let name: String
    }
}
