//
//  OrdenView.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 30/06/22.
//

import SwiftUI

struct OrdenView: View {
    @Binding var orden: Orden
    
    var total: Double {
        return (Double(orden.cantidad) * orden.platillo.precio)
    }
    var formattedTotal: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter.string(from: total as NSNumber)!
    }
    
    var body: some View {
            VStack (spacing: 5) {
//                PlatilloView(platillo: orden.platillo)
                Text(orden.platillo.nombre)
                    .font(.custom("ABeeZee", size: 20))
                Campo(labelText: "Total", systemImage: "dollarsign.circle") {
                    Text(formattedTotal)
                }
                Campo(labelText: "Instrucciones Especiales", systemImage: "rectangle.and.pencil.and.ellipsis") {
                    RoundedTextField(title: "Sin instrucciones especiales", text: $orden.instruccionesEspeciales)
                }
                Campo(labelText: "Cantidad", systemImage: "square.fill.text.grid.1x2") {
                    HStack {
                        Button {
                            orden.cantidad -= 1
                        } label: {
                            Image(systemName: "minus.circle")
                                .font(.title)
                        }
                        
                        Text("\(orden.cantidad)")
                            .font(.custom("ABeeZee", size: 20))
                            .padding()
                            .overlay(
                                Circle()
                                    .stroke(lineWidth: 2)
                            )
                        Button {
                            orden.cantidad += 1
                        } label: {
                            Image(systemName: "plus.circle")
                                .font(.title)
                        }
                    }
                }
            }
            .padding()
            .background(.background)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 0.3)
            )
            .cornerRadius(10)
    }
}

struct OrdenView_Previews: PreviewProvider {
    @State static var orden = ordenPreview1
    
    static var previews: some View {
        OrdenView(orden: $orden)
    }
}
