//
//  PortadaViewModel.swift
//  IphoneIpadFirebase
//
//  Created by mac1 on 25/06/21.
//

import Foundation
import  Firebase


class PortadaViewModel: ObservableObject {
    
    
    @Published var data: UIImage? = nil
    let sharedImage = ImageHelper()
    
    init(imageUrl: String) {
     
        if let imageInCache = sharedImage.cache.object(forKey: imageUrl as NSString ) {
            print("imagen en cache")
            self.data = imageInCache
            
        }else {
            let storageImage = Storage.storage().reference(forURL: imageUrl)
            storageImage.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                
                if let error = error?.localizedDescription {
                    print("error al traer la imagen", error)
                }else {
                    DispatchQueue.main.async {
                        let imagenFirestore = UIImage(data: data!)
                        self.sharedImage.cache.setObject(imagenFirestore!, forKey: NSString(string: imageUrl))
                        self.data = imagenFirestore
                        print("imagen traida de firestorage")
                    }
                }
            }
        }

        
    }
}

class ImageHelper {
    
    
    public static var shared = ImageHelper()
    
    let cache = NSCache<NSString, UIImage>()
    
}
