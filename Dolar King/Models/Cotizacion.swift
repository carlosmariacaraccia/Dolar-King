//
//  Cotizacion.swift
//  Dolar King
//
//  Created by Carlos Caraccia on 12/3/20.
//

import Foundation

struct Cotizacion:Codable {

    let casa:Casa?
    
    struct Casa:Codable {
        let compra, venta, agencia, nombre: String?
        let variacion, ventaCero, decimales, mejorCompra: String?
        let mejorVenta, fecha, recorrido: String?
        
    }

}
