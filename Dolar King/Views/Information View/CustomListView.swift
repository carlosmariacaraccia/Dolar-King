//
//  CustomListView.swift
//  Dolar King
//
//  Created by Carlos Caraccia on 12/17/20.
//

import SwiftUI

struct CustomListView: View {
    
    @EnvironmentObject var buscardorDeCotizaciones:BuscadorDeCotizaciones
    
    var body: some View {
        List {
            ForEach(buscardorDeCotizaciones.currencyObjects, id:\.self.name!) { currency in
                CotizacionesCell(currency: currency)
            }
        }
    }
}

