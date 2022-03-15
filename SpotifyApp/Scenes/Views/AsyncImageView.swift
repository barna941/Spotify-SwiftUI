import SwiftUI

struct AsyncImageView: View {
    private let url: URL

    @StateObject
    private var imageLoader = ImageLoader(imageCache: DependencyProvider.resolver.resolve(ImageCaching.self)!)

    init(url: URL) {
        self.url = url
    }

    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                Image(systemName: "music.mic.circle.fill")
                    .resizable()
                    .foregroundColor(Color.textPrimary)
            }
        }
        .onAppear {
            imageLoader.loadImage(from: url)
        }
    }
}
