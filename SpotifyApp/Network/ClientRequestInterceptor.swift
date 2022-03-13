import Alamofire
import Foundation

final class ClientRequestInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        request.headers["Authorization"] = "Bearer \(token)"
        completion(.success(request))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
}

private let token = "BQADsNZQ3Gb-g1BzNN2FtbA99ZOXtXc3c1vZjH7bfw_2F2P2fjjz5hv-9d_y5OIVsvVEeCwoI8ot39mXRFhpP6yPkkYIbhMbWOTMo911VzGtgEKfPuFeEOMb_XdGIdu64lwxa3MhQsnOa7zGaCnW1MDFumHQJDd-RnP2du24EUctnhQu0IIzxDYKDJEM22VoFL6S0hSxbX-L8Cf7TXrxpwl2RwwdgWtU-es"
