//
//  CarritoView.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 29/06/22.
//

import SwiftUI

struct CarritoView: View {
    @Binding var carrito: [Orden]
    var eliminarOrden: (Orden) -> Void
    var vaciarCarrito: () -> Void
    
    @State var isShowingFormularioPago = false
    
    //MARK: Toast state
    @State var isShowingToast: Bool = false
    @State var toastMessage: String = ""
    @State var toastType: ToastType = .success
    
    var body: some View {
        ScrollView {
            if !carrito.isEmpty {
                VStack {
                    Label("Toca y manten para ver opciones", systemImage: "lightbulb.fill")
                        .font(.custom("ABeeZee", size: 14))
                        .foregroundColor(.yellow)
                    ForEach($carrito) {orden in
                        OrdenView(orden: orden)
                            .contextMenu {
                                RoundedButton(text: "Eliminar", systemImage: "trash") {
                                    eliminarOrden(orden.wrappedValue)
                                }
                            }
                    }
                }
                .padding()
            } else {
                VStack (spacing: 0) {
                    LottieView(name: "empty-cart")
                        .frame(height: 300)
                    Text("Carrito Vacío")
                        .font(.custom("Secular One", size: 24))
                }
            }
        }
        .toast(isPresented: $isShowingToast, text: toastMessage, type: toastType)
        .safeAreaInset(edge: .bottom) {
            if !carrito.isEmpty {
                VStack(spacing: 0) {
                    Divider()
                    VStack {
                        RoundedButton(text: "Proceder al pago") {
                            isShowingFormularioPago = true
                        }
                    }
                    .padding()
                    .background(.bar)
                }
            }
        }
        .sheet(isPresented: $isShowingFormularioPago) {
            FormularioPedido(
                vaciarCarrito: vaciarCarrito,
                carrito: carrito,
                isShowingToast: $isShowingToast,
                toastMessage: $toastMessage,
                toastType: $toastType
            )
        }
    }
}

struct CarritoView_Previews: PreviewProvider {
    @State static var carrito: [Orden] = [ordenPreview1, ordenPreview1, ordenPreview1, ordenPreview1]
    static var eliminarOrden: (Orden) -> Void = { _ in }
    static var vaciarCarrito: () -> Void = {}
    
    static var previews: some View {
        CarritoView(
            carrito: $carrito,
            eliminarOrden: eliminarOrden,
            vaciarCarrito: vaciarCarrito
        )
    }
}
