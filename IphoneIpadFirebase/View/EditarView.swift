//
//  EditarView.swift
//  IphoneIpadFirebase
//
//  Created by mac1 on 26/06/21.
//

import SwiftUI

struct EditarView: View {
    
    @State private var titulo = ""
    @State private var desc = ""
    var plataforma :String
    var datos: FirebaseModel
    @State var progress = false
    @StateObject var guardarViewModel = FirebaseViewModel()
    @State private var imageData: Data = .init(capacity: 0)
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    @Environment(\.presentationMode) var presentationMode
    
    
  
    
    
    
    
    var body: some View {
        NavigationView{
            
            ZStack{
                Color.pink.edgesIgnoringSafeArea(.all)
                ScrollView{
                    VStack{
                        // isActive por el, se ejecuta todo el navlink cuando  cambia imagePicker
                        NavigationLink( destination: ImagePicker(show: $imagePicker, image: $imageData, source: source), isActive: $imagePicker){
                            EmptyView()
                        }.navigationBarHidden(true)
                        
                        
                        TextField("Titulo", text: $titulo)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.emailAddress)  // Type Tclado
                            .disableAutocorrection(true)  //no autocorrector
                            .autocapitalization(.none) //first work Minuscula
                            .onAppear{
                                titulo = datos.titulo
                            }

                        TextEditor(text: $desc)
                            .frame( height: 100)
                            .onAppear{
                                desc = datos.desc
                            }
                        

                        
                        
                        Button(action: {
                            mostrarMenu.toggle()
                        }){
                            Text("Cargar Imagen")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.black)
                            
                        }.actionSheet(isPresented: $mostrarMenu, content: {
                            ActionSheet(title: Text("Menu"), message: Text("Seleccione una opccion"), buttons: [.default(Text("Camara"), action: {
                                source = .camera
                                imagePicker.toggle()}),
                                .default(Text("Libreria"), action: {
                                    source = .photoLibrary
                                    imagePicker.toggle()
                                }),
                                .default(Text("Cancelar"))
                            ])
                        })
                        
                        if imageData.count != 0 {
                            Image(uiImage: UIImage(data: imageData)!)
                                .resizable()
                                .frame(width: 200, height: 200)
                                .cornerRadius(15)
                            
                            }
                        Button(action: {
                            if imageData.isEmpty {
                                guardarViewModel.edit(titulo: titulo, desc: desc, plataforma: plataforma, id: datos.id) { (done) in
                                    if done {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            }else {
                                progress = true
                                guardarViewModel.editWithImage(titulo: titulo, desc: desc, plataforma: plataforma, id: datos.id, index: datos, portada: imageData) { (done) in
                                    if done {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            }
                        }){
                            Text("Guardar")
                                .foregroundColor(.black)
                                .bold()
                                .font(.largeTitle)
                            
                        }
                        if progress {
                            Text("Espere un momento por favor ...").foregroundColor(.black)
                            ProgressView()
                        }
                        
                        
                        Spacer()
                    }.padding(.all)
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}


