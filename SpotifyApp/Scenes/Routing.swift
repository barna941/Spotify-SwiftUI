import SwiftUI

protocol Routing {
    associatedtype Route
    associatedtype Body: View

    @ViewBuilder func view(for route: Route) -> Self.Body
}
