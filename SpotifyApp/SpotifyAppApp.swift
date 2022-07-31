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

        configureNavBarAppearance()
        configureTabBarAppearance()
    }

    private func configureNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        UITabBar.appearance().standardAppearance = appearance
    }
}
