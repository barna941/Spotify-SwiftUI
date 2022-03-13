import Alamofire
import Combine
import Foundation

protocol NetworkClientProtocol {
    func request<T: Encodable, U: Decodable>(
        url: URL,
        method: HTTPMethod,
        parameters: T?,
        encoder: ParameterEncoder
    ) -> AnyPublisher<U, Error>
}

final class NetworkClient: NetworkClientProtocol {

    private let session = Session()
    private let interceptor: RequestInterceptor

    init(interceptor: RequestInterceptor) {
        self.interceptor = interceptor
    }

    func request<T: Encodable, U: Decodable>(
        url: URL,
        method: HTTPMethod,
        parameters: T?,
        encoder: ParameterEncoder = JSONParameterEncoder.default
    ) -> AnyPublisher<U, Error> {
        session
            .request(url, method: method, parameters: parameters, encoder: encoder, interceptor: interceptor)
            .cURLDescription(calling: { description in
                print(description)
            })
            .validate()
            .publishData()
            .tryMap { [weak self] dataResponse in
                switch dataResponse.result {
                case let .success(data):
                    self?.debugLog(data: data)
                    return data
                case let .failure(error):
                    throw error
                }
            }
            .decode(type: U.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension NetworkClient {
    private func debugLog(data: Data) {
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        } else {
            print("Malformed JSON")
        }
    }
}
