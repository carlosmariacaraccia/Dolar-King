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
    
    @State private var cotizaciones:[Cotizacion]
    
    @State private var chooseExchangeToConvert:String = "Pesos to USD"
    @State private var amountToConvert:String = "0.0"
    private let exchangeCurrencySelection:[String] = ["Pesos to USD", "USD to Pesos"]
    
    init(cotizaciones:[Cotizacion]) {
        _cotizaciones = State(wrappedValue: cotizaciones)
    }
    
    var body: some View {
        VStack {
            Text("Exchange selector")
                .font(.custom("OCR-A", size: 20))
                .opacity(0.7)
            
            Picker(selection: $chooseExchangeToConvert, label: Text("")) {
                ForEach(exchangeCurrencySelection, id:\.self) { currency in
                    Text(currency)
                        .font(.custom("OCR-A", size: 8))
                        .opacity(0.5)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .background(Color.init(hex: "DFF0FE").opacity(0.6))
            .foregroundColor(Color.init(hex: "DFF0FE").opacity(0.6))
            .opacity(0.7)
            
            HStack {
                Text(chooseExchangeToConvert == "Pesos to USD" ? "ARS" : "USD")
                TextField("0", text: $amountToConvert)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
            }
            .opacity(0.7)
            .font(.custom("OCR-A", size: 40))
            
            VStack {
                HStack {
                    Image("blueUICrown80")
                        .resizable()
                        .frame(width: 60, height: 60, alignment: .center)
                    Text("Oficial")
                        .font(.custom("OCR-A", size: 30))
                        .opacity(0.7)
                    Spacer()
                    Text("Hola")
                        .font(.custom("OCR-A", size: 30))
                        .opacity(0.7)
                }
                HStack {
                    Image("blueUIMoney80")
                        .resizable()
                        .frame(width: 60, height: 60, alignment: .center)
                    Text("Blue")
                        .font(.custom("OCR-A", size: 30))
                        .opacity(0.7)
                    Spacer()
                    Text("54.22")
                        .font(.custom("OCR-A", size: 30))
                        .opacity(0.7)
                }
            }
            KeypadView()
        }
        .padding()
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
                return Double(cotizaciones.filter{($0.casa?.nombre?.contains("Bfi") ?? false)}.map{$0.casa?.venta ?? "no value"}.first?.replacingOccurrences(of: ",", with: ".") ?? "no value")
            }
            
        }
    }
    
}

struct ConversionView_Previews: PreviewProvider {
    static var previews: some View {
        ConversionView(cotizaciones: [Cotizacion]())
    }
}
