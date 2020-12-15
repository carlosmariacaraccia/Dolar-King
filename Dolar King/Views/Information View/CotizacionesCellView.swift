//
//  CotizacionesCellView.swift
//  Dolar King
//
//  Created by Carlos Caraccia on 12/11/20.
//

import SwiftUI

struct CotizacionesCell:View {
    
    @State private var cotizacion:Cotizacion
    
    init (cotizacion:Cotizacion) {
        self._cotizacion = State(wrappedValue: cotizacion)
    }
    
    private func cotizacionSelector(cotizacion:Cotizacion) -> (UIImage?,String?) {
        guard let nombreCotizacion = cotizacion.casa?.nombre else { return (nil, nil) }
        
        if nombreCotizacion.contains("Liqui") {
            return (UIImage(named: "blueUIPaycheque80"), "CCL")
        }
        if nombreCotizacion.contains("Blue") {
            return (UIImage(named: "blueUIMoney80"), "Blue")
        }
        if nombreCotizacion.contains("Oficial") {
            return (UIImage(named: "blueUICrown80"), "Oficial")
        }
        if nombreCotizacion.contains("Bolsa") {
            return (UIImage(named: "blueUIMoneyBag80"), "Bolsa")
        }
        if nombreCotizacion.contains("turista") {
            return (UIImage(named: "blueUICreditCard80"), "Turista")
        } else { return (nil, nil) }
    }
    
    var body: some View {
        if cotizacionSelector(cotizacion: cotizacion) == (nil,nil) {
            EmptyView()
        } else  {
            HStack(spacing:30) {
                
                HStack {
                    
                    Image(uiImage: (cotizacionSelector(cotizacion: cotizacion).0 ?? UIImage(systemName: "rectangle"))!)
                        .resizable()
                        .frame(width:40, height: 40)
                    
                    Text(cotizacionSelector(cotizacion: cotizacion).1 ?? "downloading")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .opacity(0.6)
                }
                Spacer()
                HStack {
                    VStack {
                        Text("\(cotizacion.casa?.compra ?? "downloading")")
                        Text("\(cotizacion.casa?.venta ?? "downloading")")
                    }
                    .foregroundColor(.black)
                    .opacity(0.6)
                    
                    Text("\(checkforMinusSign(value:cotizacion.casa?.variacion))"+"\(checkForDecimalsInVariacion(variacion:cotizacion.casa?.variacion) )")
                        .foregroundColor(checkForDecimalsInVariacion(variacion:cotizacion.casa?.variacion).contains("-") ? .red : .green)
                        .opacity(0.9)
                }
                .font(.system(size: 15))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .background(Color(hex:"F2F6FF"))
            .cornerRadius(10)
            .shadow(color: Color(hex:"EFF1F5"), radius: 4, x:0.0 , y: 8)
        }
        
    }
    
    private func checkforMinusSign(value:String?) -> String {
        if value!.contains("-") {
            return ""
        } else {
            return "+"
        }
    }
    
    private func checkForDecimalsInVariacion(variacion:String?) -> String {
        if variacion!.count < 5 {
            if variacion!.count == 1 {
                return "0,000"
            } else {
                var appending:String = variacion!
                for _ in (1...(5-variacion!.count)) {
                    appending.append("0")
                }
                return appending
            }
        } else {
            return variacion!
        }
    }

    
}

