//
//  KeypadView.swift
//  Dolar King
//
//  Created by Carlos Caraccia on 12/11/20.
//

import SwiftUI

struct KeypadView: View {
    
    let buttonsRows = [["7", "8", "9"], ["4", "5", "6"], ["1", "2", "3"], [".", "0", "←"]]
    
    var body: some View {
        
        VStack(alignment:.center) {
            VStack(alignment: .center) {
                ForEach(buttonsRows, id:\.self) { row in
                    HStack(alignment: .center, spacing: 0) {
                        ForEach(row, id:\.self) { column in
                            Button(action:{print("dalai")}, label:{
                                Text(column)
                                    .font(.custom("OCR-A", size: 70))
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5))
                            })
                        }
                    }
                }
            }
        }
    }
}
    
    
    struct KeypadView_Previews: PreviewProvider {
        static var previews: some View {
            KeypadView()
        }
    }
