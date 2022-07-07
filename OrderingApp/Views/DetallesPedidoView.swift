//
//  DetallesPedidoView.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 06/07/22.
//

import SwiftUI

struct DetallesPedidoView: View {
    var pedido: Pedido
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(pedido.productos){ orden in
                        HStack {
                            Text(orden.cantidad.description)
                            Text(orden.platillo.nombre)
                            Spacer()
                            Text(orden.formattedTotal)
                        }
                    }
                } header: {
                    SectionHeader(text: "Productos")
                }
                Section {
                    Text(pedido.formattedTotal)
                } header: {
                    SectionHeader(text: "Total")
                }
                Section {
                    Text(pedido.direccion.titular)
                    Text(pedido.direccion.contacto)
                } header: {
                    SectionHeader(text: "Recibe")
                }
                Section {
                    HStack {
                        Text(pedido.estado.rawValue)
                        Spacer()
                        Image(systemName: "square.inset.filled")
                            .foregroundColor(pedido.estado.colorEstado)
                    }
                } header: {
                    SectionHeader(text: "Estado")
                }
                Section {
                    Text(pedido._id)
                } header: {
                    SectionHeader(text: "Folio")
                }
            }
            .font(.custom("ABeeZee", size: 16))
            .navigationTitle("Detalles del Pedido")
        }
    }
}

struct DetallesPedidoView_Previews: PreviewProvider {
    
    static var previews: some View {
        DetallesPedidoView(pedido: pedidoPreview)
    }
}
