import UIKit

protocol ImageCaching {
    func image(for url: URL, completion: @escaping (UIImage?) -> Void)
    func setImage(image: UIImage, for url: URL)
}

final class ImageCache: ImageCaching {
    private var images = [URL: UIImage]()
    private let queue = DispatchQueue(label: "image.cache.queue")

    func image(for url: URL, completion: @escaping (UIImage?) -> Void) {
        queue.async {
            let image = self.images[url]
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }

    func setImage(image: UIImage, for url: URL) {
        queue.async {
            self.images[url] = image
        }
    }
}
