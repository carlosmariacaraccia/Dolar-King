//
//  InformationView.swift
//  Dolar King
//
//  Created by Carlos Caraccia on 12/11/20.
//

import SwiftUI
import Combine

struct InformationView: View {
    
    @StateObject var buscador = BuscadorDeCotizaciones()
        
    var body: some View {
        
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
                ForEach(buscador.cotizaciones, id:\.self.casa!.nombre) { cotizacion in
                    CotizacionesCell(cotizacion: cotizacion)
                        .padding(10)
                }
            }
        }.onAppear(perform: {
            print("performed")
            buscador.getCotizaciones()
        })
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
