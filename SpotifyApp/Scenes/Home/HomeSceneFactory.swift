import Foundation

protocol HomeSceneFactoryProtocol {
    func createHomeView() -> HomeView
}

struct HomeSceneFactory: HomeSceneFactoryProtocol {
    func createHomeView() -> HomeView {
        HomeView()
    }
}
