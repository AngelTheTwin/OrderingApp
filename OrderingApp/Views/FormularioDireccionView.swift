//
//  FormularioDireccionView.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 29/06/22.
//

import SwiftUI

enum Ciudad: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case Xalapa
    case Veracruz
    case Cordoba
}

extension Direccion {
    var isValid: Bool {
        !self.titular.isEmpty &&
        !self.calle.isEmpty &&
        !self.colonia.isEmpty &&
        !self.ciudad.isEmpty &&
        !self.codigoPostal.isEmpty &&
        !self.contacto.isEmpty
    }
    
    var isNuevaDireccion: Bool {
        id.isEmpty
    }
}

struct FormularioDireccionView: View {
    @AppStorage("loggeduser") var usuarioData = Data()
    @State var direccion: Direccion
    var refetch: () -> Void
    
    //MARK: Loading state
    @State private var isLoading = false
    
    //MARK: Modal State
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
                Text("Detalles de la Dirección")
                    .font(.custom("Secular One", size: 24))
                Campo (labelText: "Titular", systemImage: "person") {
                    RoundedTextField(title: "Ej: Luis Dominguez", text: $direccion.titular)
                        .textContentType(.name)
                }
                Campo(labelText: "Calle", systemImage: "mappin.and.ellipse") {
                    RoundedTextField(title: "Ej: Insurgentes #35", text: $direccion.calle)
                        .textContentType(.streetAddressLine1)
                }
                Campo (labelText: "Colonia", systemImage: "map") {
                    RoundedTextField(title: "Ej: Aguacatal", text: $direccion.colonia)
                        .textContentType(.streetAddressLine2)
                }
                Campo(labelText: "Ciudad", systemImage: "location") {
                    Picker("Ciudad", selection: $direccion.ciudad) {
                        ForEach(Ciudad.allCases, id: \.self) { ciudad in
                            Text(ciudad.rawValue)
                                .tag(ciudad.rawValue)
                        }
                    }
                    .cornerRadius(20)
                    .pickerStyle(SegmentedPickerStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke()
                    )
                }
                Campo (labelText: "Código Postal", systemImage: "shippingbox") {
                    RoundedTextField (title: "Ej: 95403", text: $direccion.codigoPostal)
                        .textContentType(.postalCode)
                }
                Campo (labelText: "Telefono de Contacto", systemImage: "phone") {
                    RoundedTextField (title: "Ej: 2288554466", text: $direccion.contacto)
                        .textContentType(.telephoneNumber)
                }
                
                //MARK: Loading animation
                if (isLoading) {
                    LottieView(name: "loading")
                        .frame(height: 50)
                }
                
                //MARK: Buttons
                RoundedButton(text: direccion.isNuevaDireccion ? "Guardar" : "Actualizar") {
                    Task {
                        let performMutation = direccion._id.isEmpty ? guardarDireccion : actualizarDireccion
                        await performMutation()
                    }
                }
                .disabled(!direccion.isValid)
                
                if (!direccion.isNuevaDireccion) {
                    RoundedButton(text: "Eliminar", color: Color("AccentColor2")) {
                        Task {
                            await eliminarDireccion()
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    func guardarDireccion () async {
        do {
            guard usuario != nil  else {
                print("usuarioData corrupted")
                return
            }
            var respuesta = Respuesta()
            try await performWithLoading {
                respuesta =  try await DireccionDAO.createDireccion(direccion, of: usuario!)
            }
            showToast(message: respuesta.mensaje!, type: .success)
            refetch()
        } catch RequestError.serverError(let mensaje) {
            print("Error DireccionDAO.createDireccion", mensaje)
            showToast(message: "Ocurrió un error inesperado.", type: .error)
        } catch {
            print("Error Guardar direccion", error)
            showToast(message: "Ocurrió un error inesperado.", type: .error)
        }
        dismiss()
    }
    
    func actualizarDireccion() async {
        do {
            guard usuario != nil  else {
                print("usuarioData corrupted")
                return
            }
            var respuesta = Respuesta()
            try await performWithLoading {
                respuesta = try await DireccionDAO.updateDireccion(direccion, of: usuario!)
            }
            showToast(message: respuesta.mensaje!, type: .success)
            refetch()
        } catch RequestError.serverError(let mensaje) {
            print("Error DireccionDAO.updateDireccion", mensaje)
            showToast(message: "Ocurrió un error inesperado.", type: .error)
        } catch {
            print("Error Actualizar dirección", error)
            showToast(message: "Ocurrió un error inesperado.", type: .error)
        }
        dismiss()
    }
    
    func eliminarDireccion() async {
        do {
            guard usuario != nil  else {
                print("usuarioData corrupted")
                return
            }
            var respuesta = Respuesta()
            try await performWithLoading {
                respuesta = try await DireccionDAO.deleteDireccion(direccion, of: usuario!)
            }
            showToast(message: respuesta.mensaje!, type: .success)
            refetch()
        } catch RequestError.serverError(let mensaje) {
            print("Error DireccionDAO.deleteDireccion", mensaje)
            showToast(message: "Ocurrió un error inesperado.", type: .error)
        } catch {
            print("Error Eliminar dirección", error)
            showToast(message: "Ocurrió un error inesperado.", type: .error)
        }
        dismiss()
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

struct FormularioDireccionView_Previews: PreviewProvider {
    @State static var direccion = direccionPreview1
    @State static private var toastMessage: String = ""
    @State static private var isShowingToast: Bool = false
    @State static private var toastType: ToastType = .success
    
    static var previews: some View {
        FormularioDireccionView(
            direccion: direccion,
            refetch: refetch,
            toastMessage: $toastMessage,
            isShowingToast: $isShowingToast,
            toastType: $toastType
        )
    }
    
    static func refetch() {}
}
