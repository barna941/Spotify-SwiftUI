import SwiftUI

struct AppCoordinatorView: View {

    @ObservedObject
    var coordinator: AppCoordinator

    var body: some View {
        coordinator.view(for: .dashboard)
    }
}
