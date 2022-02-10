//
//  ListView.swift
//  IphoneIpadFirebase
//
//  Created by mac1 on 26/06/21.
//

import SwiftUI

struct ListView: View {
    
    var device = UIDevice.current.userInterfaceIdiom
    var plataforma :String
    @Environment(\.horizontalSizeClass) var width
    @StateObject var datosViewModel = FirebaseViewModel()
    @State private var showEdit = false
    
    
    func getColumns() -> Int{
        return (device == .pad) ? 3 : ((device == .phone && width == .regular) ? 3 : 1)
    }
    
    
    var body: some View {
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: getColumns()), spacing: 10){
                ForEach(datosViewModel.datos){ item  in
                    CardView(titulo: item.titulo, portada: item.portada, index: item, plataforma: plataforma)
                        /*.onTapGesture {
                            showEdit.toggle()
                        }.sheet(isPresented: $showEdit, content: {
                            EditarView(plataforma: plataforma, datos: item)
                        }) Borrar por trabajar de mas*/
                        .padding(.all)
                }
            }
        }.onAppear{
            datosViewModel.getData(plataforma: plataforma)
        }
    }
}


