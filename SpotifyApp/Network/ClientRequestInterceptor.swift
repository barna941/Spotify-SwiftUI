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

private let token = "BQCz_yEQ93yD-hi_TlX8VVGOKJjou-SmOvrplT1TLUa4xreU-MSd863pq3H-ozIxM-yVJ1TIhCqN9QwEv4jwI7MEVzT5b6CYSxSSUp2SHzE8Q-ackGG9fZidK9HouV-i17V101dV0r3GTTljWUE-dHKus-XzH8V4ptIl1gV96oRBwi_6pts5X3ulf49soyALUvr--gpgqHm0Mt18tIW_14oCX1ANSxY71ZA"
