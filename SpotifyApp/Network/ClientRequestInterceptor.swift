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

private let token = "BQCkIFTpsE8p8wJv1vjNCLZA6M-xCHkwvxZITgBVO1JxajUAwoIiuSniwI98Q9LjX8lGczY6wkgoW2cRdGpvQN6EOFtdOAq_xgB16Z9rRJsiwIakh8vU3diaeGR1V-wK1UmYkVQaQ7W5y30aMokjNG2rcziQtU5eXN58zCpP2WgTt72mDWBeF9tabQ"
