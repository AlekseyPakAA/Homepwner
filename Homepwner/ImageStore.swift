
import Foundation
import UIKit

class ImageStore {
    
    let cache = NSCache<NSString, UIImage>()
    
    func set(image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func get(imageFor key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func delete(imageFor key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
}
