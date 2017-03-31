
import Foundation
import UIKit

class ImageStore {
    
    let cache = NSCache<NSString, UIImage>()
    
    func set(image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
        
        let imgURL = get(urlFor: key)
        
        if let data = UIImagePNGRepresentation(image) {
            do {
                try data.write(to: imgURL, options: .atomic)
            } catch {
                print("Error saving image to disk")
            }
        }
    }
    
    func get(imageFor key: String) -> UIImage? {
        if let imgFromCache = cache.object(forKey: key as NSString) {
            return imgFromCache
        }
        
        let url = get(urlFor: key)
        guard let imgFromDisk = UIImage.init(contentsOfFile: url.path) else {
            return nil
        }
        
        cache.setObject(imgFromDisk, forKey: key as NSString)
        return imgFromDisk
    }
    
    func get(urlFor key: String) -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(key)
    }
    
    func delete(imageFor key: String) {
        cache.removeObject(forKey: key as NSString)
        do {
            try FileManager.default.removeItem(at: get(urlFor: key))
        } catch {
            
        }
    }
    
}
