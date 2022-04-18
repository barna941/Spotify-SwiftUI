import Foundation

protocol LibrarySceneFactoryProtocol {
    func createLibraryView() -> LibraryView
}

struct LibrarySceneFactory: LibrarySceneFactoryProtocol {
    func createLibraryView() -> LibraryView {
        LibraryView()
    }
}
