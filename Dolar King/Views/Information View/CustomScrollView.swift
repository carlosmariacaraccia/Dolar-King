//
//  CustomScrollView.swift
//  Dolar King
//
//  Created by Carlos Caraccia on 12/17/20.
//

import SwiftUI

struct CustomScrollView : UIViewRepresentable {
    
    var width : CGFloat
    var height : CGFloat
    
    @EnvironmentObject var buscadorDeCotizaciones:BuscadorDeCotizaciones
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, model: buscadorDeCotizaciones)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let control = UIScrollView()
        control.refreshControl = UIRefreshControl()
        control.refreshControl?.addTarget(context.coordinator, action:
                                            #selector(Coordinator.handleRefreshControl),
                                          for: .valueChanged)
        let childView = UIHostingController(rootView: CustomListView().environmentObject(buscadorDeCotizaciones))
        childView.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        control.addSubview(childView.view)
        return control
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {}
    
    class Coordinator: NSObject {
        var control: CustomScrollView
        var model : BuscadorDeCotizaciones
        init(_ control: CustomScrollView, model: BuscadorDeCotizaciones) {
            self.control = control
            self.model = model
        }
        @objc func handleRefreshControl(sender: UIRefreshControl) {
            sender.endRefreshing()
            model.useDolarHoy()
        }
    }
}
