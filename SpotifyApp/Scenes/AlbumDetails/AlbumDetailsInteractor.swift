import Foundation
import Combine

protocol AlbumDetailsInteractorProtocol {
    func tracks(for albumId: String) -> AnyPublisher<AlbumTracksResponseDTO, Error>
}

final class AlbumDetailsInteractor: AlbumDetailsInteractorProtocol {

    private let albumApi: AlbumApiProtocol

    init(albumApi: AlbumApiProtocol) {
        self.albumApi = albumApi
    }

    func tracks(for albumId: String) -> AnyPublisher<AlbumTracksResponseDTO, Error> {
        albumApi.tracks(for: albumId)
    }
}
