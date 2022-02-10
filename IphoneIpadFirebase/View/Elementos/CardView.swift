//
//  CardView.swift
//  IphoneIpadFirebase
//
//  Created by Jorge Maldonado Borbón on 19/01/21.
//

import SwiftUI

struct CardView: View {
    
    var titulo: String
    var portada: String
    var index: FirebaseModel
    var plataforma: String
    
    @StateObject var datos = FirebaseViewModel()
    
    var body: some View {
        VStack(spacing: 20){
            //Image("imagen")
            ImagenFirebase(imageUrl: portada)
            
            Text(titulo)
                .font(.title)
                .bold()
                .foregroundColor(.black)
            Button(action: {
                datos.delete(index: index, plataforma: plataforma)
            }){
                Text("Eliminar")
                    .foregroundColor(.red)
                    .padding(.vertical,5)
                    .padding(.horizontal,25)
                    .background(Capsule().stroke((Color.red)))
                
            }
        }.padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}


