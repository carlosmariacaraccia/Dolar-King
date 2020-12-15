//
//  ContentView.swift
//  Dolar King
//
//  Created by Carlos Caraccia on 12/3/20.
//

import SwiftUI
import Combine

struct MainView: View {
    
    @StateObject var buscadorDeCotizaciones = BuscadorDeCotizaciones()
    
    var body: some View {
        TabView {
            InformationView(cotizationes: buscadorDeCotizaciones.cotizaciones)
                .tabItem {
                    Image("graph25")
                        .renderingMode(.template)
                        .padding()
                    Text("Information")
                }
            ConversionView(cotizaciones: buscadorDeCotizaciones.cotizaciones)
                .environmentObject(DisplayShower())
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
        MainView()
    }
}
