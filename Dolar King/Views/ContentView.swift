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
        
        TabView {
            VStack(spacing:30) {
                
                ZStack(alignment: .bottom) {
                    
                    Image("stockGraph")
                        .resizable()
                        .frame(width:300, height:250)
                    
                    Text("Ultimos Valores")
                        .font(.custom("OCR-A", size: 35))
                        .shadow(color: .black, radius: 4, x: 0.0, y: 4)
                        .offset(y: -20)
                        .opacity(0.6)
                }
                ScrollView {
                    ForEach(buscadorDeCotizaciones.cotizaciones, id:\.self.casa!.nombre) { cotizacion in
                        CotizacionesCell(cotizacion: cotizacion)
                            .padding(10)
                    }
                }
            }
                .tabItem {
                    Image("graph25")
                        .renderingMode(.template)
                        .padding()
                    Text("Information")
                    
                }
            ConversionView(cotizaciones: buscadorDeCotizaciones.cotizaciones)
                .tabItem {
                    Image("calculator25")
                        .renderingMode(.template)
                        .padding()
                    Text("Conversion")
                }

        }
        .onAppear(perform: {
            buscadorDeCotizaciones.getCotizaciones()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
