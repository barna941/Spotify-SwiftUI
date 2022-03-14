import Foundation

protocol ViewModelProtocol: ObservableObject {
    associatedtype Route

    var activeNavigation: Route? { get set }
}
