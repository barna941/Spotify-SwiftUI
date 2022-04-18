import SwiftUI

enum DashboardRoute: String, CaseIterable, Hashable {
    case home
    case search
    case library

    var id: String { rawValue }
}

extension DashboardRoute: TabBarButtonRepresentable {
    var name: String { rawValue.capitalized }

    var imageName: String {
        switch self {
        case .home:
            return "house"
        case .search:
            return "magnifyingglass"
        case .library:
            return "books.vertical"
        }
    }

    var selectedImageName: String {
        switch self {
        case .home:
            return "house.fill"
        case .search:
            return "sparkle.magnifyingglass"
        case .library:
            return "books.vertical.fill"
        }
    }
}
