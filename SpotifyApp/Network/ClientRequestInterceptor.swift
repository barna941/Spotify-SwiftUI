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

private let token = "BQA94UzC2H8tljQDf4NVk0e3wR9d4JIpqeOggHqnugCgd22Ng5lDMukecIKML8_L-973hAQwqx13UoJ756jDX-ulm32uw7QHjvM_lR4i3x_aou-v_TTeVUW5mC9k124BNm73bie5a93uqqYBwmTe0G1SUAi21uWFwCHXrbYlmjUzu553ccouj7JubUqB-6QEpvzx7rKfFjKviXjT0_C9SyFA0viyuPMfjsU"
