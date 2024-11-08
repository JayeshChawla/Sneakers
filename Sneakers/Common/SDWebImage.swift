import Kingfisher
import UIKit

class ImageLoader {
    static let shared = ImageLoader()

    private init() {}

    @MainActor func loadImage(
        from url: String?,
        into imageView: UIImageView,
        placeholder: UIImage? = nil,
        progress: ((Int64, Int64) -> Void)? = nil // Optional progress block
    ) {
        guard let urlString = url, let imageURL = URL(string: urlString) else {
            imageView.image = placeholder
            return
        }

        // Set the options for image loading
        let options: KingfisherOptionsInfo = [
            .cacheOriginalImage, // Cache the original image
            .progressiveJPEG(.default), // Use progressive loading for JPEGs
            .forceRefresh // Force refresh the image if needed
        ]

        // Using Kingfisher to load the image into the UIImageView
        imageView.kf.setImage(
            with: imageURL,
            placeholder: placeholder,
            options: options,
            progressBlock: { receivedSize, totalSize in
                // This will track the download progress
                progress?(receivedSize, totalSize)
            },
            completionHandler: { result in
                // Handle the completion (success or failure)
                switch result {
                case .success(let value):
                    print("Image loaded successfully: \(value.image)")
                case .failure(let error):
                    print("Error loading image: \(error.localizedDescription)")
                }
            }
        )
    }
}
