import Alamofire
import Swinject

final class DependencyProvider {

    private static let provider = DependencyProvider()
    static var resolver: Resolver { provider.container }

    private let container = Container()
    private lazy var assembler = Assembler(container: container)

    static func registerServices() {
        provider.assembler.apply(
            assemblies: [
                CoreAssembly(),
                NetworkAssembly(),
                DashboardAssembly(),
                HomeAssembly(),
                SearchAssembly(),
                LibraryAssembly(),
                AlbumAssembly()
            ]
        )
    }
}

final class CoreAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AppCoordinator.self) { r in
            AppCoordinator(dashboardSceneFactory: r.resolve(DashboardSceneFactoryProtocol.self)!)
        }
        container.register(ImageCaching.self) { _ in
            ImageCache()
        }.inObjectScope(.container)
        container.register(ImageLoading.self) { r in
            ImageLoader(imageCache: r.resolve(ImageCaching.self)!)
        }
    }
}

final class NetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkClientProtocol.self) { r in
            NetworkClient(interceptor: r.resolve(RequestInterceptor.self)!)
        }
        container.register(RequestInterceptor.self) { _ in
            ClientRequestInterceptor()
        }
        container.register(SearchApiProtocol.self) { r in
            SearchApi(client: r.resolve(NetworkClientProtocol.self)!)
        }
        container.register(AlbumApiProtocol.self) { r in
            AlbumApi(client: r.resolve(NetworkClientProtocol.self)!)
        }
    }
}

final class DashboardAssembly: Assembly {
    func assemble(container: Container) {
        container.register(DashboardSceneFactoryProtocol.self) { r in
            DashboardSceneFactory()
        }
        container.register(DashboardCoordinator.self) { r in
            DashboardCoordinator(
                homeSceneFactory: r.resolve(HomeSceneFactoryProtocol.self)!,
                searchSceneFactory: r.resolve(SearchSceneFactoryProtocol.self)!,
                librarySceneFactory: r.resolve(LibrarySceneFactoryProtocol.self)!
            )
        }
    }
}

final class HomeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeSceneFactoryProtocol.self) { _ in
            HomeSceneFactory()
        }
    }
}

final class SearchAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SearchInteractorProtocol.self) { r in
            SearchInteractor(searchApi: r.resolve(SearchApiProtocol.self)!)
        }
        container.register(SearchViewModel.self) { r, coordinator in
            SearchViewModel(
                interactor: r.resolve(SearchInteractorProtocol.self)!,
                coordinator: coordinator as SearchCoordinator
            )
        }
        container.register(SearchSceneFactoryProtocol.self) { _ in
            SearchSceneFactory()
        }
        container.register(SearchCoordinator.self) { r in
            SearchCoordinator(sceneFactory: r.resolve(SearchSceneFactoryProtocol.self)!)
        }
    }
}

final class LibraryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LibrarySceneFactoryProtocol.self) { _ in
            LibrarySceneFactory()
        }
    }
}

final class AlbumAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AlbumDetailsViewModel.self) { r, album in
            AlbumDetailsViewModel(
                album: album,
                interactor: r.resolve(AlbumDetailsInteractorProtocol.self)!,
                imageLoader: ImageLoader(imageCache: DependencyProvider.resolver.resolve(ImageCaching.self)!)
            )
        }
        container.register(AlbumDetailsInteractorProtocol.self) { r in
            AlbumDetailsInteractor(albumApi: r.resolve(AlbumApiProtocol.self)!)
        }
    }
}
