//
//  DireccionesView.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 29/06/22.
//

import SwiftUI

var fetchDirecciones: () async throws -> [Direccion] = {
    @AppStorage("loggeduser") var usuarioData = Data()
    guard (!usuarioData.isEmpty) else {
        print("No user data")
        return []
    }
    let usuario = try! JSONDecoder().decode(Usuario.self, from: usuarioData)
    let direcciones: [Direccion] = try await DireccionDAO.readAllDirecciones(of: usuario)
    return direcciones
}

struct DireccionesView: View {
    @Query(query: fetchDirecciones) var direcciones = []
    
    @State private var selectedDireccion: Direccion? = nil
    
    //MARK: Toast state
    @State private var toastMessage: String = ""
    @State private var isShowingToast: Bool = false
    @State private var toastType: ToastType = .success
    
    var body: some View {
        ScrollView {
            VStack {
                RoundedButton(text: "Nueva Dirección", systemImage: "mappin.and.ellipse") {
                    let nuevaDireccion = Direccion()
                    selectedDireccion = nuevaDireccion
                }
                .padding()
                if ($direcciones.isLoading) {
                    LottieView(name: "loading")
                        .frame(width: 100, height: 100)
                }
                if direcciones.isEmpty {
                        LottieView(name: "empty-direcciones")
                            .frame(height: 250)
                            .padding()
                        Text("No hay direcciones registradas")
                            .font(.custom("Secular One", size: 24))
                } else {
                    ForEach ($direcciones.bindingValue) { direccion in
                        DireccionView(direccion: direccion.wrappedValue)
                            .onTapGesture {
                                selectedDireccion = direccion.wrappedValue
                            }
                    }
                }
            }
            .padding(.horizontal)
            .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero)
        }
        .onAppear {
            $direcciones.refetch()
        }
        //MARK: Modal
        .sheet(
            item: $selectedDireccion,
            onDismiss: {
                withAnimation {
                    direcciones = direcciones.filter({ direccion in
                        !direccion.id.isEmpty
                    })
                }
                $direcciones.refetch()
            },
            content: { direccion in
                FormularioDireccionView(
                    direccion: direccion,
                    refetch: $direcciones.refetch,
                    toastMessage: $toastMessage,
                    isShowingToast: $isShowingToast,
                    toastType: $toastType
                )
            }
        )
        //MARK: Toast
        .toast(isPresented: $isShowingToast, text: toastMessage, type: toastType)
    }
}


struct DireccionesView_Previews: PreviewProvider {
    @State static var direcciones: [Direccion] = direccionesPreview
    
    static var previews: some View {
        DireccionesView(
            direcciones: direcciones
        )
    }
}
