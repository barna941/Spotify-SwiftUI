import Foundation
import Combine

protocol SearchInteractorProtocol {
    func search(for keyword: String) -> AnyPublisher<SearchResponseDTO, Error>
}

final class SearchInteractor: SearchInteractorProtocol {

    private let searchApi: SearchApiProtocol

    init(searchApi: SearchApiProtocol) {
        self.searchApi = searchApi
    }

    func search(for keyword: String) -> AnyPublisher<SearchResponseDTO, Error> {
        let request = SearchRequestDTO(query: keyword, types: SearchRequestDTO.SearchType.allCases)
        return searchApi.search(request: request)
    }
}
