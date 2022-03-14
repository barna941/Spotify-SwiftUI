import SwiftUI
import Combine

@main
struct SpotifyAppApp: App {

    private let appRouter = AppRouter()

    var body: some Scene {
        WindowGroup {
            appRouter.view(for: .initial)
        }
    }

    init() {
        DependencyProvider.registerServices()
    }
}
