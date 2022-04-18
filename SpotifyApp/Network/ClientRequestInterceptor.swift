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

private let token = "BQA6CPoo9h6NWyQkJS7vAY6B6lZwMIJnPmBxH5ekzBgqYoepRR_8cxIfxD17iKkWUvQBhwydn2jQkgClEE6AWDZ6z4yoGoYqiXk3iaXaN6dIhfuuRFl7d8HkgQxVpWxprMTKAK6GB9QCYHPC1ARWcam90K37MXYy-nDWB0y8k2jbenU2AuStHppf5BIyoXb7jTFnFt33agszV4OxzpT1mKsZuZ23ybU9LnA"
