//
//  KeypadView.swift
//  Dolar King
//
//  Created by Carlos Caraccia on 12/11/20.
//

import SwiftUI


struct KeypadView: View {
    
    @EnvironmentObject var displayShower: DisplayShower
    
    let buttons:[[CalculatorButton]] = [
        [.seven, .eight, .nine],
        [.four, .five, .six],
        [.one, .two, .three],
        [.decimal, .zero, .backspace]]
    
    var buttonWidth:CGFloat {
        // we will have 3 buttons per row and we will leave 5 pts of padding from each side of them (endings).
        // and we will have 10- of inner padding between button and button
        (UIScreen.main.bounds.width - 25)/3
    }
    
    var body: some View {
        VStack(spacing:10) {
            ForEach(buttons, id:\.self) { row in
                HStack {
                    ForEach(row, id:\.self) { button in
                        Button(action:
                                {self.displayShower.receiveInput(calculatorButton: button)},
                               label:{
                                Text(button.title)
                                    .frame(width:buttonWidth, height:buttonWidth / 2)
                                    .font(.system( size: 50))
                                    .foregroundColor(Color.init(hex: "4788C7")).opacity(0.7)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5)
                                                .foregroundColor(Color.init(hex: "4788C7")).opacity(0.9))
                               })
                    }
                }
            }
        }
    }
}


struct KeypadView_Previews: PreviewProvider {
    static var previews: some View {
        KeypadView().environmentObject(DisplayShower())
    }
}
