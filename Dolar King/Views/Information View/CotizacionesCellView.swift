//
//  CotizacionesCellView.swift
//  Dolar King
//
//  Created by Carlos Caraccia on 12/11/20.
//

import SwiftUI

struct CotizacionesCell:View {
    
    @State private var currency:CurrencyObject
    
    
    init (currency:CurrencyObject) {
        self._currency = State(wrappedValue: currency)
    }
    
    private func currencySelector(currency:CurrencyObject) -> (UIImage?,String?) {
        guard let nombreCotizacion = currency.name else { return (nil, nil) }
        
        if nombreCotizacion.contains("Liqui") {
            return (UIImage(named: "blueUIPaycheque80"), "CCL")
        }
        if nombreCotizacion.contains("Blue") {
            return (UIImage(named: "blueUIMoney80"), "Blue")
        }
        if nombreCotizacion.contains("ofi") {
            return (UIImage(named: "blueUICrown80"), "Oficial")
        }
        if nombreCotizacion.contains("Bolsa") {
            return (UIImage(named: "blueUIMoneyBag80"), "Bolsa")
        }
        if nombreCotizacion.contains("Solidario") {
            return (UIImage(named: "blueUICreditCard80"), "Turista")
        } else { return (nil, nil) }
    }
    
    var body: some View {
        if currencySelector(currency: currency) == (nil,nil) {
            EmptyView()
        } else  {
            HStack(spacing:30) {
                
                HStack {
                    Image(uiImage: (currencySelector(currency: currency).0 ?? UIImage(systemName: "rectangle"))!)
                        .resizable()
                        .frame(width:40, height: 40)
                    Text(currencySelector(currency: currency).1 ?? "downloading")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .opacity(0.6)
                }
                Spacer()
                HStack {
                    VStack {
                        Text(String(format:"%.2f", currency.buyPrice ?? 0.00))
                        Text(String(format:"%.2f", currency.sellPrice ?? 0.00))
                            .foregroundColor(.black)
                            .opacity(0.6)
                        
                        Text("\(currency.variation ?? 0.000)")
                            .foregroundColor((currency.variation ?? 0.00) < 0 ? .red : .green)
                            .opacity(0.9)
                    }
                    .font(.system(size: 15))
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .background(Color(hex:"F2F6FF"))
            .cornerRadius(10)
            .shadow(color: Color(hex:"EFF1F5"), radius: 4, x:0.0 , y: 8)
        }
        
    }
    
}
