//
//  BuscadorDeCotizaciones.swift
//  Dolar King
//
//  Created by Carlos Caraccia on 12/3/20.
//


import SwiftUI
import Combine

// View Model
class BuscadorDeCotizaciones:ObservableObject {
    
    @Published var cotizaciones = [Cotizacion]()
    
    private var cancellable:AnyCancellable?
    
    func getCotizaciones() {
        
        let dolarSiUrl = URL(string: "https://www.dolarsi.com/api/api.php?type=valoresprincipales")
        
        self.cancellable = URLSession.shared.dataTaskPublisher(for: dolarSiUrl!)
            .map { $0.data }
            .decode(type:[Cotizacion].self, decoder:JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.cotizaciones, on: self)
    }
    
}
