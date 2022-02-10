//
//  Login.swift
//  IphoneIpadFirebase
//
//  Created by mac1 on 24/06/21.
//

import SwiftUI

struct Login: View {
    
    @State private var email = ""
    @State private var pass = ""
    @StateObject var login = FirebaseViewModel()
    @EnvironmentObject var loginShow: FirebaseViewModel
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.purple.edgesIgnoringSafeArea(.all)
                VStack{
                    Text("My Games")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .frame(width: device == .pad ? 400 : nil)
                    
                    SecureField("Pass", text: $pass)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: device == .pad ? 400: nil)
                        .padding(.top, 20)
                        
                    Button(action: {
                        login.login(email: email, pass: pass) { (done) in
                            if done {
                                UserDefaults.standard.set(true,forKey: "sesion")
                                loginShow.show = 1
                                
                            }
                        }
                    }){
                        Text("Entrar")
                            .font(.title)
                            .frame(width: 200)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                    }.background(
                        Capsule()
                            .stroke(Color.white))
                    .padding(.top,20)
                       
                    
                    NavigationLink(destination: Register(), label: {
                        Text( "Registrar")
                            .font(.title)
                            .frame(width: 200)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .background(Capsule().stroke(Color.white)).padding(.top,20)
                        
                    })
                    Button(action: {
                   
                        loginShow.register.toggle()
                        loginShow.show = 2
                      
                        
                    /*    login.registrar(email: email, pass: pass) { (done) in
                            if done {
                                UserDefaults.standard.set(true,forKey: "sesion")
                                loginShow.show.toggle()
                            }
                        }*/
                    }){
                        Text("Registrar")
                            .font(.title)
                            .frame(width: 200)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                    }.background(
                        Capsule()
                            .stroke(Color.white))
                    .padding(.top,20)
                }.padding(.all)
            }.navigationBarHidden(true)
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

/*struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}*/
