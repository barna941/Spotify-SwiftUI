import Alamofire
import Foundation
import Combine

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
