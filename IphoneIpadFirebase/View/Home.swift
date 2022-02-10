//
//  Home.swift
//  IphoneIpadFirebase
//
//  Created by Jorge Maldonado Borbón on 19/01/21.
//

import SwiftUI

struct
Home: View {
    @State private var index = "Playstation"
    @State private var menu = false
    @State private var widthMenu = UIScreen.main.bounds.width
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    

    
    var body: some View {
        ZStack{
            VStack{
                NavBar(index: $index, menu: $menu)
                ZStack{
                    if index == "Playstation" {  //leen cambios
 /*                       ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: getColumns()), spacing: 20){
                                ForEach(1...9, id:\.self){ _ in
                                    CardView(titulo: titulo, portada: <#T##String#>)
                                        .padding(.all)
                                }
                            }
                        }*/
                        ListView(plataforma: "playstation")
                    }else if index == "Xbox"{
                        ListView(plataforma: "xbox")

                    }else if index == "Nintendo"{
                        ListView(plataforma: "nintendo")

                    } else{
                        AddView()
                    }
                }
            }
            // termina navbar ipad
            if menu { //lee cambios
                HStack{
                    Spacer()
                    VStack{
                        HStack{
                            Spacer()
                            Button(action:{
                                withAnimation{
                                    menu.toggle()
                                }
                            }){
                                Image(systemName: "xmark")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }.padding()
                        .padding(.top, 50)
                        VStack(alignment: .trailing){
                            ButtonView(index: $index, menu: $menu, title: "Playstation")
                            ButtonView(index: $index, menu: $menu, title: "Xbox")
                            ButtonView(index: $index, menu: $menu, title: "Nintendo")
                            ButtonView(index: $index, menu: $menu, title: "Agregar")
                        }
                        Spacer()
                    }
                    .frame(width: widthMenu - 150)
                    .background(Color.purple)
                }
            }
        }.background(Color.gray.opacity(0.5))
    }
}


/*struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
        Home()
        Home()
    }
  }
}*/
