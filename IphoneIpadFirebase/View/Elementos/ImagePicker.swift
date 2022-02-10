//
//  ImagePicker.swift
//  IphoneIpadFirebase
//
//  Created by mac1 on 25/06/21.
//

import Foundation
import SwiftUI


struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var show: Bool
    @Binding var image: Data
    var source: UIImagePickerController.SourceType
    
    // se ejecuta utomaticamnte, por el protocolo Representable
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePicker.Coordinator(conexion: self)
    }
    // es aquí cuando ya está preparado SwiftUI para mostrar la vista y luego controlar el ciclo de vida del UIViewController,
    func makeUIViewController(context: Context) -> some UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = source
        controller.allowsEditing = true
        controller.delegate = context.coordinator
        return controller
        
        
    }
    
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        print("actualizaod")
    }
    
    
    class Coordinator: NSObject,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var conexion: ImagePicker
        
        init(conexion: ImagePicker) {
            self.conexion = conexion
        }
        
        //Se ejecuta cuando cancelamos la tomade foto
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("Se concelo")
            self.conexion.show.toggle()
        }
        
        
        //Aqui se toma la fotografia
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage]as! UIImage
            let data = image.jpegData(compressionQuality: 0.10)
            self.conexion.image = data!
            self.conexion.show.toggle()
        }
    }
}


