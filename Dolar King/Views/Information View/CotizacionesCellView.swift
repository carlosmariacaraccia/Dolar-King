//
//  CotizacionesCellView.swift
//  Dolar King
//
//  Created by Carlos Caraccia on 12/11/20.
//

import SwiftUI

struct CotizacionesCell:View {
    
    var currency:CurrencyObject
    
    private var dateFormatter:DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.timeStyle = .medium
        return formatter
    }
    
    init (currency:CurrencyObject) {
        self.currency = currency
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
            ProgressView()
        } else  {
            HStack {
                HStack(spacing:10) {
                    Image(uiImage: (currencySelector(currency: currency).0 ?? UIImage(systemName: "rectangle"))!)
                        .resizable()
                        .frame(width:40, height: 40)
                    Text(currencySelector(currency: currency).1 ?? "downloading")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .opacity(0.6)
                }
                Spacer()
                VStack(alignment:.center) {
                    Text(currency.variation == nil ? "0.000" : String(format:"%.2f", currency.variation!))
                        .foregroundColor((currency.variation ?? 0.00) < 0 ? .red : .green)
                        .opacity(0.9)
                    Text(dateFormatter.string(from: currency.timeStamp!))
                        .font(.system(size: 10, weight: .light, design: .default))
                }
                .padding(.trailing, 5)
                VStack(alignment:.center) {
                    Text(currency.buyPrice == nil ? "No cotiza" : String(format:"%.3f", currency.buyPrice!))
                    Text(currency.sellPrice == nil ? "No cotiza" : String(format:"%.3f", currency.sellPrice!))
                        .foregroundColor(.black)
                }
                .font(.system(size: 15))
                .opacity(0.6)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .background(Color(hex:"F2F6FF"))
            .cornerRadius(10)
            .shadow(color: Color(hex:"EFF1F5"), radius: 4, x:0.0 , y: 8)
        }
    }
}

struct CotizacionesCellView_Preview: PreviewProvider {
    static var previews: some View {
        let curr = CurrencyObject(name: "Bolsa", buyPrice: 10, sellPrice: 20, variation: 0.05, timeStamp: Date())
        return CotizacionesCell(currency: curr)
    }
}
