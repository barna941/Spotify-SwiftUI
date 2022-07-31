import Alamofire
import Foundation
import Combine

protocol AlbumApiProtocol: SpotifyApi {
    func tracks(for albumId: String) -> AnyPublisher<AlbumTracksResponseDTO, Error>
}

final class AlbumApi: AlbumApiProtocol {

    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol) {
        self.client = client
    }

    func tracks(for albumId: String) -> AnyPublisher<AlbumTracksResponseDTO, Error> {
        client
            .request(
                url: baseUrl.appendingPathComponent("albums/\(albumId)/tracks"),
                method: .get,
                parameters: Empty.value,
                encoder: URLEncodedFormParameterEncoder.default
            )
    }
}
