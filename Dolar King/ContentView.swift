//
//  ContentView.swift
//  Dolar King
//
//  Created by Carlos Caraccia on 12/3/20.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @StateObject var buscadorDeCotizaciones = BuscadorDeCotizaciones()
    
    var body: some View {
        
        VStack(spacing:30) {
            
            ZStack(alignment: .bottom) {
                
                Image("stockGraph")
                    .resizable()
                    .frame(width:300, height:250)
                
                Text("Ultimos Valores")
                    .font(.custom("OCR-A", size: 25))
                    .shadow(color: .black, radius: 4, x: 0.0, y: 4)
                    .offset(y: -20)
                    .opacity(0.6)
            }
            
            HStack(spacing:30) {
                
                HStack(spacing:3) {
                    
                    Image("blueUICrown80")
                        .resizable()
                        .frame(width:40, height: 40)
                    
                    Text("Oficial")
                        .font(.custom("OCR-A", size: 20))
                        .foregroundColor(.black)
                        .opacity(0.6)
                }
                
                HStack(spacing: 10) {
                    
                    Text("154 - 148")
                        .foregroundColor(.black)
                        .opacity(0.6)
                    
                    Text("0.65")
                        .foregroundColor(.green)
                        .opacity(0.6)
                }
                .font(.custom("OCR-A", size: 15))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .background(Color(hex:"F2F6FF"))
            .cornerRadius(10)
            .shadow(color: Color(hex:"EFF1F5"), radius: 4, x:0.0 , y: 8)
            
        }
        .onAppear(perform: {
            buscadorDeCotizaciones.getCotizaciones()
            print(buscadorDeCotizaciones.cotizaciones)
        })
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
