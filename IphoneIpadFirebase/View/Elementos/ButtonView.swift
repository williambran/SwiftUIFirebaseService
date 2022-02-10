//
//  ButtonView.swift
//  IphoneIpadFirebase
//
//  Created by Jorge Maldonado Borbón on 19/01/21.
//

import SwiftUI

struct ButtonView: View {
    @Binding var index : String
    @Binding var menu : Bool
    @Environment(\.horizontalSizeClass) var width
    var device = UIDevice.current.userInterfaceIdiom
    var title : String
    
    var body: some View {
        Button(action:{
            withAnimation{
                index = title
                if device == .phone {
                    if width == .regular {
                        
                    }else {
                        menu.toggle()
                    }
                    
                }
            }
        }){
            Text(title)
                .font(.title)
                .fontWeight(index == title ? .bold : .none)
                .foregroundColor(index == title ? .white : Color.white.opacity(0.6))
                
        }
    }
}


