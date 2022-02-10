//
//  NavBar.swift
//  IphoneIpadFirebase
//
//  Created by Jorge Maldonado Borbón on 19/01/21.
//

import SwiftUI
import Firebase

struct NavBar: View {
    
    var device = UIDevice.current.userInterfaceIdiom
    @Binding var index : String  //init con Playstation//////////////////
    @Binding var menu : Bool
    @EnvironmentObject var loginShow: FirebaseViewModel  //viene d raiz, para close session
    @Environment(\.horizontalSizeClass) var width
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    
    var body: some View {
        HStack{
            Text("My Games")
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: device == .phone ? 25 : 35))
            Spacer()
            if device == .pad || width == .regular  {
                // menu ipad
                
                HStack(spacing: 25){
                    
                    ButtonView(index: $index, menu: $menu, title: "Playstation")
                    ButtonView(index: $index, menu: $menu, title: "Xbox")
                    ButtonView(index: $index, menu: $menu, title: "Nintendo")
                    ButtonView(index: $index, menu: $menu, title: "Agregar")
                    Button(action: {
                        try! Auth.auth().signOut()
                        UserDefaults.standard.removeObject(forKey: "sesion")
                        loginShow.show = 0
                    }){
                        Text("Salir")
                            .font(.title)
                            .frame(width:100).foregroundColor(.white)
                            .padding(.horizontal,25)
                        
                    }.background(Capsule().stroke(Color.white))
                }
            }else{
                // menu iphone
                Button(action:{
                    withAnimation{
                        menu.toggle()
                    }
                }){
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                }
            }
                
        }
        .padding(.top, 60)
        .padding()
        .background(Color.purple)
    }
}


