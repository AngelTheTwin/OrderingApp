//
//  DetallesProductoView.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 29/06/22.
//

import SwiftUI

struct DetallesProductoView: View {
    var platillo: Producto
    @State var instruccionesEspeciales = ""
    @State var cantidad = 0
    
    @Environment(\.dismiss) private var dismiss
    
    var agregarACarrito: (Orden) -> Void
    
    var agregarButtonActive: Bool {
        return cantidad > 0
    }
    
    var body: some View {
        VStack (spacing: 10) {
            Text("Detalles del Platillo")
                .font(.custom("Secular One", size: 24))
            PlatilloView(platillo: platillo)
            Text(platillo.descripcion)
                .font(.custom("ABeeZee", size: 15))
            
            Divider()
            
            Text("¡Realiza tu orden!")
                .font(.custom("Secular One", size: 18))
            Campo(labelText: "Instrucciones Especiales", systemImage: "rectangle.and.pencil.and.ellipsis") {
                RoundedTextField(title: "Ej: Extra queso 🧀", text: $instruccionesEspeciales)
            }
            Label("Cantidad", systemImage: "square.fill.text.grid.1x2")
                .font(.custom("ABeeZee", size: 16))
            HStack {
                Button {
                    cantidad -= 1
                    if cantidad < 0 {
                        cantidad = 0
                    }
                } label: {
                    Image(systemName: "minus.circle")
                        .font(.title)
                }
                
                Text("\(cantidad)")
                    .font(.custom("ABeeZee", size: 20))
                    .padding()
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 2)
                    )
                Button {
                    cantidad += 1
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.title)
                }
            }
            RoundedButton(text: "Agregar al Carrito") {
                let orden = Orden(platillo: platillo, cantidad: cantidad, instruccionesEspeciales: instruccionesEspeciales)
                agregarACarrito(orden)
                withAnimation {
                    dismiss()
                }
            }
            .disabled(!agregarButtonActive)
        }
        .padding()
    }
}

struct DetallesProductoView_Previews: PreviewProvider {
    @State static var platillo = productoPreview1
    
    static var previews: some View {
        DetallesProductoView(
            platillo: platillo,
            agregarACarrito: agregarACarrito
        )
    }
    
    static func agregarACarrito(_ orden: Orden) {}
}
