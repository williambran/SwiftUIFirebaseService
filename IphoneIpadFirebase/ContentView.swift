//
//  ContentView.swift
//  IphoneIpadFirebase
//
//  Created by Jorge Maldonado Borbón on 19/01/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var  loginShow: FirebaseViewModel
    var body: some View {
        return Group {
            if loginShow.show == 1 {
                Home()
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    //.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            }else if loginShow.show == 0 {
                Login().preferredColorScheme(.light)
                
            }else {
                Register()
            }
            

        }.onAppear{
            if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                loginShow.show = 1
            }
        }
        
    }
}


