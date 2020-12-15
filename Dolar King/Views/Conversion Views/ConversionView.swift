//
//  ConversionView.swift
//  Dolar King
//
//  Created by Carlos Caraccia on 12/11/20.
//

import SwiftUI

enum tipoDeCotizacion {
    case compra
    case venta
}

enum tipoDeDolar {
    case oficial
    case blue
}

struct ConversionView: View {
    
    @EnvironmentObject var displayShower:DisplayShower
    @State private var cotizaciones:[Cotizacion]
    
    @State private var chooseExchangeToConvert:String = "Pesos to USD"
    private let exchangeCurrencySelection:[String] = ["Pesos to USD", "USD to Pesos"]
    
    init(cotizaciones:[Cotizacion]) {
        _cotizaciones = State(wrappedValue: cotizaciones)
    }
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("Exchange selector")
                .font(.system(size: 20))
                .opacity(0.7)
            Picker(selection: $chooseExchangeToConvert, label: Text("")) {
                ForEach(exchangeCurrencySelection, id:\.self) { currency in
                    Text(currency)
                        .font(.system( size: 8))
                        .opacity(0.5)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .background(Color.init(hex: "DFF0FE").opacity(0.6))
            .foregroundColor(Color.init(hex: "DFF0FE").opacity(0.6))
            .opacity(0.7)
            .padding(10)
            HStack {
                Text(chooseExchangeToConvert == "Pesos to USD" ? "ARS" : "USD")
                Spacer()
                Text(displayShower.display)
            }
            .opacity(0.7)
            .font(.system(size: 40))
            Spacer()
            VStack {
                HStack {
                    Image("blueUICrown80")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                    Text("Oficial \(chooseExchangeToConvert == "Pesos to USD" ? "USD" : "ARS")")
                        .font(.system( size: 20))
                        .opacity(0.7)
                    Spacer()
                    Text(convertCotizacion(amount: displayShower.display, fromPesosToUSD: chooseExchangeToConvert, tipo: .oficial) )
                        .font(.system( size: 30))
                        .opacity(0.7)
                }
                HStack {
                    Image("blueUIMoney80")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                    Text("Blue \(chooseExchangeToConvert == "Pesos to USD" ? "USD" : "ARS")")
                        .font(.system( size: 20))
                        .opacity(0.7)
                    Spacer()
                    Text(convertCotizacion(amount: displayShower.display, fromPesosToUSD: chooseExchangeToConvert, tipo: .blue))
                        .font(.system( size: 30))
                        .opacity(0.7)
                }
            }
            Spacer()
            KeypadView().environmentObject(displayShower)
        }
        .padding()
    }
    
    private func convertCotizacion(amount:String, fromPesosToUSD:String, tipo:tipoDeDolar) -> String {
        let amountInDouble:Double = Double(amount) ?? 0.00
        if fromPesosToUSD == "Pesos to USD" {
            let convertedAmount = amountInDouble / convertCotizacionesToDouble(cotizaciones: cotizaciones, tipoDeCotizacion: .venta, tipoDeDolar: tipo)!
            return String(format: "%.2f", convertedAmount)
        } else {
            let convertedAmount = convertCotizacionesToDouble(cotizaciones: cotizaciones, tipoDeCotizacion: .venta, tipoDeDolar: tipo)!*amountInDouble
            return String(format: "%.2f", convertedAmount)
        }
        
    }
    
    private func convertCotizacionesToDouble(cotizaciones:[Cotizacion],tipoDeCotizacion:tipoDeCotizacion, tipoDeDolar:tipoDeDolar) -> Double? {
        
        switch tipoDeCotizacion {
        case .compra:
            switch tipoDeDolar {
            case .blue:
                return Double(cotizaciones.filter{($0.casa?.nombre?.contains("Blue") ?? false)}.map{$0.casa?.compra ?? "no value"}.first?.replacingOccurrences(of: ",", with: ".") ?? "no value")
            case .oficial:
                return Double(cotizaciones.filter{($0.casa?.nombre?.contains("Ofi") ?? false)}.map{$0.casa?.compra ?? "no value"}.first?.replacingOccurrences(of: ",", with: ".") ?? "no value")
            }
        case .venta:
            switch tipoDeDolar {
            case .blue:
                return Double(cotizaciones.filter{($0.casa?.nombre?.contains("Blue") ?? false)}.map{$0.casa?.venta ?? "no value"}.first?.replacingOccurrences(of: ",", with: ".") ?? "no value")
            case .oficial:
                return Double(cotizaciones.filter{($0.casa?.nombre?.contains("Ofi") ?? false)}.map{$0.casa?.venta ?? "no value"}.first?.replacingOccurrences(of: ",", with: ".") ?? "no value")
            }
            
        }
    }
    
}

struct ConversionView_Previews: PreviewProvider {
    static var previews: some View {
        ConversionView(cotizaciones: [Cotizacion]()).environmentObject(DisplayShower())
    }
}
