import SwiftUI

struct SearchCoordinatorView: View {

    @ObservedObject
    var coordinator: SearchCoordinator

    var body: some View {
        NavigationView {
            coordinator.view(for: .search)
                .navigation(item: $coordinator.currentRoute) { route in
                    coordinator.view(for: route)
                }
                .navigationBarHidden(true)
        }
    }
}
