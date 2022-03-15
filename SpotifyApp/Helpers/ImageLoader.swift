import Combine
import UIKit

protocol ImageLoading {
    func loadImage(from url: URL)
}

final class ImageLoader: ImageLoading, ObservableObject {

    @Published
    var image: UIImage?

    private let imageCache: ImageCaching
    private var cancellable: AnyCancellable?

    init(imageCache: ImageCaching) {
        self.imageCache = imageCache
    }

    func loadImage(from url: URL) {
        imageCache.image(for: url) { [weak self] cachedImage in
            guard let self = self else { return }
            if let cachedImage = cachedImage {
                self.image = cachedImage
            } else {
                self.fetchImage(for: url)
            }
        }
    }

    private func fetchImage(for url: URL) {
        cancellable = URLSession(configuration: URLSessionConfiguration.default)
            .dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .handleEvents(receiveOutput: { [weak self] image in
                self?.cacheImage(image: image, url: url)
            })
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }

    private func cacheImage(image: UIImage?, url: URL) {
        guard let image = image else { return }
        imageCache.setImage(image: image, for: url)
    }
}
