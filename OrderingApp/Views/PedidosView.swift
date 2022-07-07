//
//  PedidosView.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 05/07/22.
//

import SwiftUI

fileprivate func fetchPedidos() async throws -> [Pedido] {
    @AppStorage("loggeduser") var usuarioData = Data()
    guard (!usuarioData.isEmpty) else {
        print("No user data")
        return []
    }
    let usuario = try! JSONDecoder().decode(Usuario.self, from: usuarioData)
    return try await PedidoDAO.readAllPedidos(of: usuario)
}

struct PedidosView: View {
    @Query(query: fetchPedidos) var pedidos = []
    
    @State private var selectedPedido: Pedido? = nil
    
    var body: some View {
        ScrollView {
            VStack {
                if $pedidos.isLoading {
                    LottieView(name: "loading")
                        .frame(width: 100, height: 100)
                }
                    VStack {
                        LazyVGrid(columns: [GridItem(), GridItem()]) {
                            ForEach(EstadoPedido.allCases, id: \.rawValue) { estado in
                                Label(estado.rawValue, systemImage: "square.inset.filled")
                                    .font(.custom("ABeeZee", size: 14))
                                    .foregroundColor(estado.colorEstado)
                            }
                        }
                        ForEach(pedidos) { pedido in
                            PedidoView(pedido: pedido)
                                .onTapGesture {
                                    selectedPedido = pedido
                                }
                                .contextMenu {
                                    RoundedButton(text: "Ver detalles", systemImage: "doc.text.magnifyingglass") {
                                        selectedPedido = pedido
                                    }
                                }
                        }
                    }
            }
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            $pedidos.refetch()
        }
        .sheet(item: $selectedPedido) { pedido in
            DetallesPedidoView(pedido: pedido)
        }
    }
}

struct PedidosView_Previews: PreviewProvider {
    static var previews: some View {
        PedidosView()
    }
}
