//
//  PlatilloView.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 29/06/22.
//

import SwiftUI

struct PlatilloView: View {
    var platillo: Producto
    var agregarACarrito: (Orden) -> Void = { _ in }
    
    @State private var showDetalles = false
    
    var formattedPrecio: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter.string(from: platillo.precio as NSNumber)!
    }
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    AsyncImage(
                        url: URL(string: platillo.imagen),
                        transaction: Transaction(animation: .default)
                    ) { phase in
                        switch phase {
                        case .empty:
                            LottieView(name: "loading")
                                .frame(width: 100, height: 100)
                        case .success(let image):
                            image
                                .resizable()
                        case .failure(_):
                            Image(systemName: "wifi.slash")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    Spacer()
                }
                VStack {
                    Spacer()
                    VStack {
                        HStack {
                            Text(platillo.nombre)
                                .font(.custom("ABeeZee", size: 16))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        HStack {
                            Text(formattedPrecio)
                                .font(.custom("ABeeZee", size: 16))
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                    .padding(12)
                    .background(Color("Gray"))
                }
            }
            .frame(width: 280, height: 205)
            .cornerRadius(20)
        }
        .onTapGesture {
            showDetalles = true
        }
        .sheet(isPresented: $showDetalles) {
            DetallesProductoView(platillo: platillo, agregarACarrito: agregarACarrito)
        }
    }
}

struct PlatilloView_Previews: PreviewProvider {
    @State static var platillo = productoPreview1
    
    static var previews: some View {
        PlatilloView(platillo: platillo)
    }
}
