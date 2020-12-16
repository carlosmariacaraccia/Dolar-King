//
//  BuscadorDeCotizaciones.swift
//  Dolar King
//
//  Created by Carlos Caraccia on 12/3/20.
//


import SwiftUI
import Combine
import SwiftSoup

// View Model
class BuscadorDeCotizaciones:ObservableObject {
    
    @Published var currencyObjects = [CurrencyObject]()
    
    private var cancellable:AnyCancellable?
    
    
    func useDolarHoy() {
        // get thet html and use the convert it to string
        let urlString:String = "https://www.dolarhoy.com"
        let urlDolarHoy:URL = URL(string: urlString)!
        self.cancellable = URLSession.shared.dataTaskPublisher(for: urlDolarHoy)
            .map{$0.data}
            .tryMap{String(data: $0, encoding: .utf8)!}
            .replaceError(with: "")
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] (value) in
                let doc = try! SwiftSoup.parse(value)
                let elem = try? doc.getElementsByClass("pill pill-coti")
                let allElements = elem!.array().map{try! $0.text()}
                let currencyObjs = allElements.map{self!.convertElementsToCurrency(inputString: $0)}
                self!.currencyObjects = currencyObjs
            })
    }
    
    private func convertElementsToCurrency(inputString:String) -> CurrencyObject  {
        
        var variacion:Double?
        var sellingPrice:Double?
        var name:String?
        let scanner:Scanner = Scanner(string: inputString)
        scanner.charactersToBeSkipped = .whitespacesAndNewlines
        scanner.locale = Locale(identifier: "es-AR")
        if inputString.contains("Solidario") {
            name = scanner.scanUpToString(" VENTA")
            let priceScanner = Scanner(string:(scanner.scanUpToString("Actualizado")?.replacingOccurrences(of: "VENTA $ ", with: ""))!)
            sellingPrice = priceScanner.scanDouble()
            let detector:NSDataDetector? = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue)
            let date:Date? = detector?.matches(in: inputString, options: [], range: NSRange(location: 0, length: inputString.count)).first!.date
            let obj:CurrencyObject = CurrencyObject(name: name, buyPrice: nil, sellPrice: sellingPrice, variation: nil, timeStamp: date)
            return obj
        }
        name = scanner.scanUpToString("COMPRA $")
        var priceScanner:Scanner = Scanner(string: scanner.scanUpToString("VENTA $ ")!.replacingOccurrences(of: "COMPRA $", with: ""))
        priceScanner.locale = Locale(identifier: "es-AR")
        let buyingPrice:Double? = priceScanner.scanDouble()
        // check for variacion
        if inputString.contains("Variación") {
            priceScanner = Scanner(string: scanner.scanUpToString("Variación")!.replacingOccurrences(of: "VENTA $ ", with: ""))
            priceScanner.locale = Locale(identifier: "es-AR")
            sellingPrice = priceScanner.scanDouble()
            priceScanner = Scanner(string: scanner.scanUpToString("Actualizado")!.replacingOccurrences(of: "Variación ", with: ""))
            variacion = priceScanner.scanDouble()
            let detector:NSDataDetector? = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue)
            let date:Date? = detector?.matches(in: inputString, options: [], range: NSRange(location: 0, length: inputString.count)).first!.date
            let obj:CurrencyObject = CurrencyObject(name: name, buyPrice: buyingPrice, sellPrice: sellingPrice, variation: variacion, timeStamp: date)
            return obj
        }
        priceScanner = Scanner(string: scanner.scanUpToString("Actualizado")!.replacingOccurrences(of: "VENTA $ ", with: ""))
        priceScanner.locale = Locale(identifier: "es-AR")
        sellingPrice = priceScanner.scanDouble()
        let detector:NSDataDetector? = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue)
        let date:Date? = detector?.matches(in: inputString, options: [], range: NSRange(location: 0, length: inputString.count)).first!.date
        let obj:CurrencyObject = CurrencyObject(name: name, buyPrice: buyingPrice, sellPrice: sellingPrice, variation: variacion, timeStamp: date)
        return obj
    }
}
