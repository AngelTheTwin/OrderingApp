//
//  PedidoView.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 05/07/22.
//

import SwiftUI

enum EstadoPedido: String, Codable, CaseIterable {
    case enProceso = "En proceso"
    case enCamino = "En Camino"
    case entregado = "Entregado"
    case cancelado = "Cancelado"
    
    var colorEstado: Color {
        switch self {
        case .enProceso:
            return .blue
        case .enCamino:
            return .orange
        case .entregado:
            return .green
        case .cancelado:
            return.red
        }
    }
}

struct PedidoView: View {
    var pedido: Pedido
    var numProductos: Int {
        pedido.productos.count
    }
    
    var body: some View {
        ZStack () {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "square.inset.filled")
                        .font(.custom("ABeeZee", size: 32))
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(pedido.estado.colorEstado)
                }
                Spacer()
            }
            
            VStack {
                Text("\(numProductos) producto(s)")
                    .font(.custom("ABeeZee", size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Recibe \(pedido.direccion.titular)")
                    .font(.custom("ABeeZee", size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Total: \(pedido.formattedTotal)")
                    .font(.custom("ABeeZee", size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .frame(width: 280)
        .frame(maxHeight: 100)
        .padding()
        .background(.background)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 0.3)
        )
    }
}

struct PedidoView_Previews: PreviewProvider {
    
    static var previews: some View {
        PedidoView(pedido: pedidoPreview)
    }
}
