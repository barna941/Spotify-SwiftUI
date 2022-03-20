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

private let token = "BQBp8SET24WloZNBDExHa3H5SKfJmTVJgLoPA9Idk_nZy4bPbWovMjIWKAWrxcdSceXG4e-kWYroIaYHQk0pDLku2hEUg0Wvs-O91VrBiwKbSc7ixPPhVgUBfJTNJYYHZUkBYkl256c58OK433HYhwvm6pzotXFcRPT-bR3SLrzHJpAzNVxV0v5Nl5zbdNQgbZ3WZsH8yt2YD2va0nvfUKUiKdr_d42sZuY"
