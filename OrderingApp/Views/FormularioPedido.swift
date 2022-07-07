//
//  FormularioPedido.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 06/07/22.
//

import SwiftUI

extension MetodoPago {
    var scrambledNumeroTarjeta: String {
        var charGroupNumbber = 1
        var count = 0
        var result = ""
        numeroTarjeta.forEach { char in
            result.append(
                charGroupNumbber > 3
                ? char
                : "*"
            )
            count += 1
            if (count > 3) {
                count = 0
                charGroupNumbber += 1
            }
        }
        return result
    }
}

struct FormularioPedido: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("loggeduser") var usuarioData = Data()
    @Query(query: fetchMetodosPago) var metodosPago: [MetodoPago] = []
    @Query(query: fetchDirecciones) var direcciones: [Direccion] = []
    @State private var direccionSeleccionada: Direccion = Direccion()
    @State private var metodoPagoSeleccionado: MetodoPago = MetodoPago()
    
    @State private var isLoadingPedido = false
    
    var vaciarCarrito: () -> Void
    
    var carrito: [Orden]
    var total: Double {
        carrito.reduce(0.0) { partialTotal, orden in
            partialTotal + orden.total
        }
    }
    var formattedTotal: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter.string(from: total as NSNumber)!
    }
    
    //MARK: Toast state
    @Binding var isShowingToast: Bool
    @Binding var toastMessage: String
    @Binding var toastType: ToastType
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(carrito) { orden in
                        HStack {
                            Text(orden.cantidad.description)
                            Text(orden.platillo.nombre)
                            Spacer()
                            Text(orden.formattedTotal)
                        }
                    }
                    HStack {
                        Text("Total")
                        Spacer()
                        Text(formattedTotal)
                    }
                } header: {
                    SectionHeader(text: "Tus platillos")
                }
                Section {
                    //MARK: Direcciones
                    if !$direcciones.isLoading {
                        if (!direcciones.isEmpty) {
                            Picker(selection: $direccionSeleccionada) {
                                ForEach(direcciones) { direccion in
                                    VStack (alignment: .leading) {
                                        Text(direccion.titular)
                                        Text(direccion.calle)
                                        Text(direccion.codigoPostal)
                                        Text(direccion.contacto)
                                    }
                                    .tag(direccion)
                                    .padding()
                                }
                            } label: {
                                Text("Dirección")
                            }
                        } else {
                            Text("No has agregado ninguna dirección.")
                        }
                    } else {
                        LottieView(name: "loading")
                            .frame(width: 30, height: 30)
                    }
                    //MARK: Metodos de pago
                    if !$metodosPago.isLoading {
                        if (!metodosPago.isEmpty) {
                            Picker(selection: $metodoPagoSeleccionado) {
                                ForEach(metodosPago) { metodoPago in
                                    VStack (alignment: .leading) {
                                        Text(metodoPago.scrambledNumeroTarjeta)
                                        Text(metodoPago.titular)
                                        Text("\(metodoPago.vigenciaMes)/\(metodoPago.vigenciaAño)")
                                    }
                                    .tag(metodoPago)
                                    .padding()
                                }
                            } label: {
                                Text("Método de Pago")
                            }
                        } else {
                            Text("No has agregado ningún método de pago.")
                        }
                    } else {
                        LottieView(name: "loading")
                            .frame(width: 30, height: 30)
                    }
                } header: {
                    SectionHeader(text: "Dirección y Método de Pago")
                }
                Section {
                    Button {
                        guard let usuario = try? JSONDecoder().decode(Usuario.self, from: usuarioData) else {
                            showToast(mensaje: "Ocurrió un error inesperado.", type: .error)
                            return
                        }
                        let pedido = Pedido(productos: carrito, total: total, metodoPago: metodoPagoSeleccionado, direccion: direccionSeleccionada, fecha: Date(), usuario: usuario.token)
                        Task {
                            do {
                                withAnimation {
                                    isLoadingPedido = true
                                }
                                let respuesta = try await PedidoDAO.createPedido(pedido, of: usuario)
                                showToast(mensaje: respuesta.mensaje!, type: .success)
                                vaciarCarrito()
                            } catch {
                                print(error)
                                showToast(mensaje: "Ocurrió un error inesperado", type: .error)
                            }
                            dismiss()
                        }
                    } label: {
                        HStack {
                            Text("Realizar Pedido")
                            if isLoadingPedido {
                                LottieView(name: "loading")
                                    .frame(width: 30, height: 30)
                            }
                        }
                    }.disabled(metodoPagoSeleccionado._id.isEmpty || direccionSeleccionada.isNuevaDireccion || isLoadingPedido)
                }
            }
            .font(.custom("ABeeZee", size: 16))
            .navigationBarTitle(
                Text("¡Realiza tu pedido!")
            )
        }
    }
    
    func showToast(mensaje: String, type: ToastType) {
        toastMessage = mensaje
        toastType = type
        isShowingToast = true
    }
}

struct PedidoFormulario_Previews: PreviewProvider {
    //MARK: Toast state
    @State static var isShowingToast: Bool = false
    @State static var toastMessage: String = ""
    @State static var toastType: ToastType = .success
    
    static var previews: some View {
        FormularioPedido(
            vaciarCarrito: vaciarCarrito,
            carrito: [ordenPreview1, ordenPreview2],
            isShowingToast: $isShowingToast,
            toastMessage: $toastMessage,
            toastType: $toastType
        )
    }
    
    static func vaciarCarrito() {}
}
