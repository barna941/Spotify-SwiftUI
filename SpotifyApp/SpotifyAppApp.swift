import SwiftUI
import Combine

@main
struct SpotifyAppApp: App {

    private let appCoordinator: AppCoordinator

    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(coordinator: appCoordinator)
        }
    }

    init() {
        DependencyProvider.registerServices()
        appCoordinator = DependencyProvider.resolver.resolve(AppCoordinator.self)!
    }
}
