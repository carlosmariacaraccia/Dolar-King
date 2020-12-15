//
//  InformationView.swift
//  Dolar King
//
//  Created by Carlos Caraccia on 12/11/20.
//

import SwiftUI
import Combine

struct InformationView: View {
    
    var cotizationes:[Cotizacion]
        
    var body: some View {
        
        VStack(spacing:30) {
            
            ZStack(alignment: .bottom) {
                
                Image("stockGraph")
                    .resizable()
                    .frame(width:300, height:250)
                    .cornerRadius(10)
                    .clipped()
                
                Text("Ultimos Valores")
                    .font(.system(size: 35))
                    .shadow(color: .black, radius: 4, x: 0.0, y: 4)
                    .offset(y: -20)
                    .opacity(0.6)
            }
            ScrollView {
                ForEach(cotizationes, id:\.self.casa!.nombre) { cotizacion in
                    CotizacionesCell(cotizacion: cotizacion)
                        .padding(10)
                }
            }
        }
        .background(Color(hex:"E3E8FF").opacity(0.7))
    }

}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(cotizationes: [Cotizacion]())
    }
}
