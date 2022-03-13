import SwiftUI
import Combine

@main
struct SpotifyAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    private var cancellableSet = Set<AnyCancellable>()
    private lazy var api = DependencyProvider.resolver.resolve(SearchApiProtocol.self)!

    init() {
        DependencyProvider.registerServices()

        api
            .search(
                request: SearchRequestDTO(query: "redhot", types: SearchRequestDTO.SearchType.allCases)
            )
            .sink(
                receiveCompletion: { completion in
                    print("completion: \(completion)")
                },
                receiveValue: { searchResponseDto in
                    print("response dto: \(searchResponseDto)")
                }
            )
            .store(in: &cancellableSet)
    }
}
