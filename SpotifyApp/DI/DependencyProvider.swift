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
                SearchAssembly()
            ]
        )
    }
}

final class CoreAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AppRouter.self) { r in
            AppRouter(dashboardRouter: r.resolve(DashboardRouter.self)!)
        }
        container.register(DashboardRouter.self) { r in
            DashboardRouter(searchRouter: r.resolve(SearchRouter.self)!)
        }
        container.register(SearchRouter.self) { r in
            SearchRouter()
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
    }
}

final class SearchAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SearchInteractorProtocol.self) { r in
            SearchInteractor(searchApi: r.resolve(SearchApiProtocol.self)!)
        }
        container.register(SearchViewModel.self) { r in
            SearchViewModel(interactor: r.resolve(SearchInteractorProtocol.self)!)
        }
        container.register(SearchRouter.self) { _ in
            SearchRouter()
        }
    }
}
