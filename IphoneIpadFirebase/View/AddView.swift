//
//  AddView.swift
//  IphoneIpadFirebase
//
//  Created by mac1 on 24/06/21.
//

import SwiftUI

struct AddView: View {
    
    @State private var titulo = ""
    @State private var desc = ""
    @State private var plataforma = "playstation"
    @StateObject var guardarViewModel = FirebaseViewModel()
    @State private var imageData: Data = .init(capacity: 0)
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    
    
    var consolas =  ["playstation", "xbox", "nintendo"]
    
    
    
    
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
                        TextEditor(text: $desc)
                            .frame( height: 100)
                        
                        Picker("console", selection: $plataforma){
                            ForEach(consolas, id:\.self){ item in
                                Text(item).foregroundColor(.black)
                                
                            }
                        }.frame( height: 100)
                        
                        
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
                            Button(action: {
                                guardarViewModel.save(titulo: titulo, desc: desc, plataforma: plataforma, portada: imageData) { (done) in
                                    if done {
                                        titulo  = ""
                                        desc = ""
                                    }
                                }
                            }){
                                Text("Guardar")
                                    .foregroundColor(.black)
                                    .bold()
                                    .font(.largeTitle)
                            
                                
                            }
                            
                        }
                        
                        
                        Spacer()
                    }.padding(.all)
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}


