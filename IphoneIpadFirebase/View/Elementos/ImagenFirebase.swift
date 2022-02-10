//
//  ImagenFirebase.swift
//  IphoneIpadFirebase
//
//  Created by mac1 on 25/06/21.
//

import SwiftUI

struct ImagenFirebase: View {
    
    let imagenlternativa = UIImage(systemName: "photo")
    @ObservedObject var imageLoader :  PortadaViewModel
    
    init(imageUrl: String) {
        
        imageLoader = PortadaViewModel(imageUrl: imageUrl)
    }
    var image: UIImage? {
        imageLoader.data //.flatMap(UIImage.init)
    }
    
    var body: some View {
        Image(uiImage: image ?? imagenlternativa!)
            .resizable()
            .cornerRadius(20)
            .shadow(radius: 8)
            .aspectRatio(contentMode: .fill)
    }
}




