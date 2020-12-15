//
//  KeypadModel.swift
//  Dolar King
//
//  Created by Carlos Caraccia on 12/14/20.
//

import Foundation

enum CalculatorButton:String {
    case seven, eight, nine
    case four, five, six
    case one, two, three
    case decimal, zero, backspace
    
    var title:String {
        switch self {
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .decimal:
            return "."
        case .zero:
            return "0"
        case .backspace:
            return "←"
        }
    }
}
