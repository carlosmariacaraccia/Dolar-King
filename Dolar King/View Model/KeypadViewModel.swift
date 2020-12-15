//
//  KeypadViewModel.swift
//  Dolar King
//
//  Created by Carlos Caraccia on 12/14/20.
//

import Foundation
import Combine

class DisplayShower: ObservableObject {
    
    @Published var display = "0"
    
    /// Function to modify the recieving inputo from the view
    /// - Parameter calculatorButton: an enum that belongs to the model
    func receiveInput(calculatorButton: CalculatorButton) {
        if (display != "0" && calculatorButton.title == "←" && display.count != 1) {
            display = String(display.dropLast())
        } else if (calculatorButton.title !=  "←" && display != "0" && calculatorButton.title != ".") {
            display.append(calculatorButton.title)
        } else if (calculatorButton.title !=  "←" && display == "0") {
            display = String(display.dropLast())
            display.append(calculatorButton.title)
        } else if (calculatorButton.title ==  "←" && display.count == 1 && display != "0") {
            display = "0"
        } else if (calculatorButton.title == "." && !display.contains(".")) {
            display.append(calculatorButton.title)
        } else if (display == "0" && calculatorButton.title == "←") {
        }
    }
}
