//
//  Register.swift
//  IphoneIpadFirebase
//
//  Created by mac1 on 24/06/21.
//

import SwiftUI

struct Register: View {
    
    @State private var email = ""
    @State private var pass = ""
    @EnvironmentObject var loginShow: FirebaseViewModel
    
    
    var body: some View {
        
        
        ZStack{
            Color.purple.edgesIgnoringSafeArea(.all)
            VStack{
                Text("Registrar Usuario")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .bold()
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)  // Type Tclado
                    .disableAutocorrection(true)  //no autocorrector
                    .autocapitalization(.none) //first work Minuscula
                    .padding(.top, 25)
                
                
                SecureField("Pass", text: $pass)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, 20)
                
                Button(action: {
                    loginShow.createUser(email: email, pass: pass) { (user) in
                        if user {
                            UserDefaults.standard.set(true,forKey: "sesion")
                            loginShow.show = 1
                        }
                    }
                }){
                    Text("Entrar")
                    
                }

            }.padding(.all)
        }
   
        
    }
}


