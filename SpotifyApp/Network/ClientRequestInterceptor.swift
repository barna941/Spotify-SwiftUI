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

private let token = "BQAipx53eiF-GerOE56-w9dDWzA19Evd0nEGoc8HCOhi6i0_6Fbx9RUsP3DTszcQjdJX8c8jD1FCTFdnM5d56vlBnsqWqvBIZD0OKAvQeFx7Ht0MuhLmo2cr5Ox-Dk5lI84_aPy2fPEvcFguYSiiH9X65TlEwPeA_dLqbJvBgl2FbttzYiO_zqnPiJoHE5MMGlktVIvoIRQkGRtw6eJpyR_1SKYhNcBBBIs"
