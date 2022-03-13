import Alamofire
import Foundation
import Combine

protocol SpotifyApi {
    var baseUrl: URL { get }
}

extension SpotifyApi {
    var baseUrl: URL {
        URL(string: "https://api.spotify.com/v1")!
    }
}

protocol SearchApiProtocol: SpotifyApi {
    func search(request: SearchRequestDTO) -> AnyPublisher<SearchResponseDTO, Error>
}

final class SearchApi: SearchApiProtocol {

    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol) {
        self.client = client
    }

    func search(request: SearchRequestDTO) -> AnyPublisher<SearchResponseDTO, Error> {
        client
            .request(
                url: baseUrl.appendingPathComponent("search"),
                method: .get,
                parameters: request,
                encoder: URLEncodedFormParameterEncoder.default
            )
    }
}
