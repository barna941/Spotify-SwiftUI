import Foundation

protocol SpotifyApi {
    var baseUrl: URL { get }
}

extension SpotifyApi {
    var baseUrl: URL {
        URL(string: "https://api.spotify.com/v1")!
    }
}
