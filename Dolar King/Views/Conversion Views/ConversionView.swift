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
    @State private var currencies:[CurrencyObject]
    
    @State private var chooseExchangeToConvert:String = "Pesos to USD"
    private let exchangeCurrencySelection:[String] = ["Pesos to USD", "USD to Pesos"]
    
    init(currencies:[CurrencyObject]) {
        _currencies = State(wrappedValue: currencies)
    }
    
    var body: some View {
        
        VStack {
            Text("Currency Converter")
                .font(.system(size: 30, weight: .semibold, design: .default))
                .shadow(color: .gray, radius: 4, x:0.0 , y: 8)
                .opacity(0.7)
            Spacer()
            Text("Exchange selector")
                .font(.system(size: 15))
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
                    .padding(.leading, 10)
                Spacer()
                Text(displayShower.display)
            }
            .background(Color.init(hex: "F2F6FF").opacity(0.6))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5))
            .shadow(color: Color(hex:"EFF1F5"), radius: 4, x:0.0 , y: 8)
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
                    Text(convertMoney(amount: displayShower.display, fromPesosToUSD: chooseExchangeToConvert, tipoDeDolar: .oficial, currencies: currencies))
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
                    Text(convertMoney(amount: displayShower.display, fromPesosToUSD: chooseExchangeToConvert, tipoDeDolar: .blue, currencies: currencies))
                        .font(.system( size: 30))
                        .opacity(0.7)
                }
            }
            Spacer()
            KeypadView().environmentObject(displayShower)
        }
        .padding()
    }
    
    private func convertMoney(amount:String, fromPesosToUSD:String, tipoDeDolar:tipoDeDolar, currencies:[CurrencyObject]) -> String {
        let amountInDouble:Double = Double(amount) ?? 0.00
        if fromPesosToUSD == "Pesos to USD" {
            switch tipoDeDolar {
            case .blue:
                let result = amountInDouble / currencies.filter{$0.name?.contains("Blue") ?? false }.first!.sellPrice!
                return String(format: "%.2f", result)
            case .oficial:
                let result = amountInDouble / currencies.filter{$0.name?.contains("ofi") ?? false}.first!.sellPrice!
                return String(format: "%.2f", result)
            }
        } else {
            switch tipoDeDolar {
            case .blue:
                let result = amountInDouble * currencies.filter{$0.name?.contains("Blue") ?? false}.first!.buyPrice!
                return String(format: "%.2f", result)
            case .oficial:
                let result = amountInDouble * currencies.filter{$0.name?.contains("ofi") ?? false}.first!.buyPrice!
                return String(format: "%.2f", result)
            }

        }
    }
}

struct ConversionView_Previews: PreviewProvider {
    static var previews: some View {
        ConversionView(currencies: [CurrencyObject]()).environmentObject(DisplayShower())
    }
}
