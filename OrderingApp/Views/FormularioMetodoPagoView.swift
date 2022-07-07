//
//  FormularioMetodoPagoView.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 30/06/22.
//

import SwiftUI
import Combine

fileprivate extension MetodoPago {
    var isValid: Bool {
        !titular.isEmpty &&
        !numeroTarjeta.isEmpty &&
        !vigenciaMes.isEmpty &&
        !vigenciaAño.isEmpty &&
        !cvv.isEmpty
    }
}

struct FormularioMetodoPagoView: View {
    @AppStorage("loggeduser") var usuarioData = Data()
    @State var metodoPago: MetodoPago
    @State private var isCardFlipped = false
    @State private var cardRotation = 0.0
    @FocusState private var cvvOnFocus: Bool
    var refetch: () -> Void
    
    private var esNuevaTarjeta: Bool {
        return metodoPago._id.isEmpty
    }
    
    //MARK: Loading state
    @State private var isLoading = false
    
    //MARK: Modal state
    @Environment(\.dismiss) var dismiss
    
    //MARK: Toast state
    @Binding var toastMessage: String
    @Binding var isShowingToast: Bool
    @Binding var toastType: ToastType
    
    //MARK: Getting the data from the stored user
    var usuario: Usuario? {
        guard !usuarioData.isEmpty else {
            return nil
        }
        let usuario = try? JSONDecoder().decode(Usuario.self, from: usuarioData)
        return usuario
    }
    
    
    var body: some View {
        ScrollView {
            VStack (spacing: 12) {
                Text("Detalles del Método de Pago")
                    .font(.custom("Secular One", size: 24))
                CardView(
                    card: $metodoPago,
                    hideNumber: !esNuevaTarjeta,
                    isFLipped: $isCardFlipped,
                    rotationDegrees: $cardRotation
                )
                if esNuevaTarjeta {
                    Campo(labelText: "Numero de Tarjeta", systemImage: "creditcard") {
                        RoundedTextField(title: "Ej: 5555 4444 5555 4444", text: $metodoPago.numeroTarjeta)
                            .textContentType(.creditCardNumber)
                            .onReceive(Just(metodoPago.numeroTarjeta)) { _ in
                                limitText(&metodoPago.numeroTarjeta, to: 16)
                            }
                    }
                }
                Campo(labelText: "Titular", systemImage: "person") {
                    RoundedTextField(title: "Ej: Rafael Lopez Padilla", text: $metodoPago.titular)
                        .textContentType(.name)
                }
                Campo(labelText: "Vigencia", systemImage: "calendar") {
                    HStack {
                        Campo(labelText: "Mes", systemImage: "calendar.circle") {
                            RoundedTextField(title: "Mes", text: $metodoPago.vigenciaMes)
                                .keyboardType(.numberPad)
                                .onReceive(Just(metodoPago.vigenciaMes)) { _ in
                                    limitText(&metodoPago.vigenciaMes, to: 2)
                                }
                        }
                        Campo(labelText: "Año", systemImage: "calendar.circle") {
                            RoundedTextField(title: "Año", text: $metodoPago.vigenciaAño)
                                .keyboardType(.numberPad)
                                .onReceive(Just(metodoPago.vigenciaAño)) { _ in
                                    limitText(&metodoPago.vigenciaAño, to: 2)
                                }
                        }
                    }
                }
                if esNuevaTarjeta {
                    Campo(labelText: "CVV", systemImage: "key.viewfinder") {
                        RoundedTextField(title: "Ej: 0000", text: $metodoPago.cvv)
                            .keyboardType(.numberPad)
                            .onReceive(Just(metodoPago.cvv)) { _ in
                                limitText(&metodoPago.cvv, to: 4)
                            }
                            .focused($cvvOnFocus)
                            .onChange(of: cvvOnFocus) { cvvOnFocus in
                                withAnimation {
                                    isCardFlipped = cvvOnFocus
                                    cardRotation = isCardFlipped ? 180.0 : 0.0
                                }
                            }
                    }
                }
                //MARK: Loading Animation
                if (isLoading) {
                    LottieView(name: "loading")
                        .frame(height: 50)
                }
                //MARK: Buttons
                RoundedButton(text: esNuevaTarjeta ? "Guardar" : "Actualizar") {
                    let perform = esNuevaTarjeta ? guardarMetodoPago : actualizarMetodoPago
                    Task {
                        await perform()
                    }
                }
                .disabled(!metodoPago.isValid)
                
                if (!esNuevaTarjeta) {
                    RoundedButton(text: "Eliminar", color: Color("AccentColor2")) {
                        Task {
                            await eliminarMetodoPago()
                        }
                    }
                }
            }.padding()
        }
    }
    
    func guardarMetodoPago () async {
        do {
            guard usuario != nil else {
                print("usuarioData corrupted")
                return
            }
            var respuesta: Respuesta = Respuesta()
            try await performWithLoading {
                respuesta = try await MetodoPagoDAO.createMetodoPago(metodoPago, of: usuario!)
                refetch()
            }
            showToast(message: respuesta.mensaje!, type: .success)
        } catch RequestError.serverError(let mensaje) {
            print("Error MetodoPagoDAO.createMetodoPago", mensaje)
            showToast(message: "Ocurrió un error inesperado.", type: .error)
        } catch {
            print("Error Guardar metodo de pago", error)
            showToast(message: "Ocurrió un error inesperado.", type: .error)
        }
        dismiss()
    }
    
    func actualizarMetodoPago () async {
        do {
            guard usuario != nil else {
                print("usuarioData corrupted")
                return
            }
            var respuesta = Respuesta()
            try await performWithLoading {
                respuesta = try await MetodoPagoDAO.updateMetodoPago(metodoPago, of: usuario!)
                refetch()
            }
            showToast(message: respuesta.mensaje!, type: .success)
        } catch RequestError.serverError(let mensaje) {
            print("Error MetodoPagoDAO.updateMetodoPago", mensaje)
            showToast(message: "Ocurrió un error inesperado.", type: .error)
        } catch {
            print("Error Actualizar metodo de pago", error)
            showToast(message: "Ocurrió un error inesperado.", type: .error)
        }
        dismiss()
    }
    
    func eliminarMetodoPago () async {
        do {
            guard usuario != nil else {
                print("usuarioData corrupted")
                return
            }
            var respuesta: Respuesta = Respuesta()
            try await performWithLoading {
                respuesta = try await MetodoPagoDAO.deleteMetodoPago(metodoPago, of: usuario!)
            }
            showToast(message: respuesta.mensaje!, type: .success)
            refetch()
        } catch RequestError.serverError(let mensaje) {
            print("Error MetodoPagoDAO.deleteMetodoPago", mensaje)
            showToast(message: "Ocurrió un error inesperado.", type: .error)
        } catch {
            print("Error Eliminar metodo de pago", error)
            showToast(message: "Ocurrió un error inesperado.", type: .error)
        }
        dismiss()
    }
    
    func limitText(_ text: inout String, to upper: Int) {
        if text.count > upper {
            text = String(text.prefix(upper))
        }
    }
    
    func performWithLoading(_ action: () async throws -> Void) async throws {
        withAnimation {
            isLoading = true
        }
        try await action()
        withAnimation {
            isLoading = false
        }
    }
    
    func showToast(message: String, type: ToastType) {
        toastMessage = message
        toastType = type
        withAnimation {
            isShowingToast = true
        }
    }
}

struct FormularioMetodoPagoView_Previews: PreviewProvider {
    @State static var metodoPago = cardPreview1
    //MARK: Toast state
    @State static var toastMessage: String = ""
    @State static var isShowingToast: Bool = false
    @State static var toastType: ToastType = .success
    
    static var previews: some View {
        FormularioMetodoPagoView(
            metodoPago: metodoPago,
            refetch: refetch,
            toastMessage: $toastMessage,
            isShowingToast: $isShowingToast,
            toastType: $toastType
        )
    }
    
    static func refetch() {}
}
