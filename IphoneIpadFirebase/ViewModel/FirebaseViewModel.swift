//
//  FirebaseViewModel.swift
//  IphoneIpadFirebase
//
//  Created by mac1 on 24/06/21.
//

import Foundation
import Firebase

class FirebaseViewModel: ObservableObject {
    
    @Published var show = 0
    @Published var register = false
    @Published var  datos = [FirebaseModel]()
    
    
    func login(email: String, pass: String, completion: @escaping (_ done: Bool) -> Void ){
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if user != nil {
                print("entro")
                completion(true)
              //  self.show.toggle()
                
            }else {
                if  error != nil {
                    print("error en firebase")
                }else {
                    print("error del sistema")
                }
            }
        }
    }
    
    func createUser(email: String, pass: String, completion: @escaping (_ done: Bool) -> Void ){
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            if user != nil {
                print("entro y se registro")
                completion(true)
            }else{
                if error != nil {
                    print("error en firebase")
                }else {
                    print("error del sistema")
                }
                
            }
        }
    }
    //BASE DE DATOS
    
    //GUARDAR
    func save(titulo: String, desc: String, plataforma: String, portada: Data, completion: @escaping(_ done: Bool)-> Void){
        
        
        let storage = Storage.storage().reference()
        let nombrePortada = UUID()
        let directorio = storage.child("imagenes/\(nombrePortada)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        directorio.putData(portada,metadata: metadata){data  , error in
            if error == nil {
/*                directorio.downloadURL { (url, error) in
                    print("el link de las iganes", url ?? "sin url")
                }*/
                print("guardo la imagen ")
                //GUARDAR TEXTO
                self.saveText(titulo: titulo, desc: desc, plataforma: plataforma, portada: String(describing: directorio)){ (done) in
                    if done {
                        completion(done)
                    }
                    
                }
                //TERMINO DE GUARDAR TEXTO
            }else {
                print("fallo la app")
            }
        }
        
      /*  let db = Firestore.firestore()
        let id = UUID().uuidString
        
        guard let idUser = Auth.auth().currentUser?.uid else {return}
        guard let email = Auth.auth().currentUser?.email else {return}
        let campos: [String:Any] = ["titulo":titulo,"desc": desc, "portada": portada,"idUser": idUser, "email": email]
        db.collection(plataforma).document(id).setData(campos){ error in
            if let error = error?.localizedDescription{
                print("Error al guardar en firebase")
            }else {
                print("Guardo todo")
                completion(true)
            }
        }*/
    }
    
    func saveText(titulo: String,desc: String,plataforma:String,portada: String, completion: @escaping(_ done: Bool)-> Void )  {
          let db = Firestore.firestore()
          let id = UUID().uuidString
          
          guard let idUser = Auth.auth().currentUser?.uid else {return}
          guard let email = Auth.auth().currentUser?.email else {return}
          let campos: [String:Any] = ["titulo":titulo,"desc": desc, "portada": portada,"idUser": idUser, "email": email]
          db.collection(plataforma).document(id).setData(campos){ error in
            if (error?.localizedDescription) != nil{
                  print("Error al guardar en firebase")
              }else {
                  print("Guardo todo")
                completion(true)
                 
              }
          }
    }
    
    
    //MOSTRAR LOS DATOS
    func getData (plataforma: String) {
        let db = Firestore.firestore()
        
        db.collection(plataforma).addSnapshotListener{ QuerySnapshot,error in
            if let error = error?.localizedDescription {
                print("error al mostrar datos", error)
            }else {
                self.datos.removeAll() //import, por que esta escuchando datos, y hay que limpiarla
                for  document in QuerySnapshot!.documents {
                    let valor = document.data()
                    let id = document.documentID
                    let titulo = valor["titulo"] as? String ?? "sin titulo"
                    let desc = valor["desc"] as? String ?? "Sin descripcion"
                    let portada = valor["portada"] as? String ?? "sin portada"
                    print(" **** *** id de los documentos", id)
                    
                    DispatchQueue.main.async {
                        let registros = FirebaseModel(id: id, titulo: titulo, desc: desc, portada: portada)
                        self.datos.append(registros)
                    }
                    
                }
            }
            
        }
    }
    
    
    //ELIMINAR
    func delete(index: FirebaseModel, plataforma: String) {
        // elimina firestore
        let id = index.id
        let db = Firestore.firestore()
        db.collection(plataforma).document(id).delete()
        
        //eliminar del storaje
        let imagen = index.portada
        let borrarImagen = Storage.storage().reference(forURL: imagen)
        borrarImagen.delete(completion: nil)
    }
    
    func edit(titulo:String,desc: String, plataforma: String, id:String, completion: @escaping(_ done: Bool) -> Void) {
        let db = Firestore.firestore()
        let campos : [String: Any] = ["titulo": titulo, "desc:": desc]
        db.collection(plataforma).document(id).updateData(campos){ error in
            if (error?.localizedDescription) != nil {
                print("Error al editar")
            }else {
                print("se edito texto")
                completion(true)
            }
        }
    }
    
    func editWithImage(titulo:String,desc: String, plataforma: String, id:String,index: FirebaseModel,portada: Data, completion: @escaping(_ done: Bool) -> Void) {
        //Eliminar imagen
        let imagen = index.portada
        let borrarImagen = Storage.storage().reference(forURL: imagen)
        borrarImagen.delete(completion: nil)
        
        //Subir la nueva imagen
        
        let storage = Storage.storage().reference()
        let nombrePortada = UUID()
        let directorio = storage.child("imagenes/\(nombrePortada)")
        //  let folderReference = storage.reference(withPath: "fotos-tweets/\(imageName).jpg") otra forma de hacerlo
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        directorio.putData(portada,metadata: metadata){data  , error in
            if error == nil {
                print("guardo la imagen nueva ")
                //editando TEXTO
                let db = Firestore.firestore()
                let campos : [String: Any] = ["titulo": titulo, "desc:": desc, "portada": String(describing: directorio)]
                db.collection(plataforma).document(id).updateData(campos){ error in
                    if (error?.localizedDescription) != nil {
                        print("Error al editar")
                    }else {
                        print("se edito texto")
                        completion(true)
                    }
                }
                //TERMINO DE GUARDAR TEXTO
            }else {
                print("fallo la app")
            }
        }
        
        
    }
    
}
