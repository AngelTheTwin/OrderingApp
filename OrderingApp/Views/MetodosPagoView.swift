//
//  MetodosPagoView.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 30/06/22.
//

import SwiftUI

var fetchMetodosPago: () async throws -> [MetodoPago] = {
    @AppStorage("loggeduser") var usuarioData = Data()
    guard (!usuarioData.isEmpty) else {
        print("No user data")
        return []
    }
    let usuario = try! JSONDecoder().decode(Usuario.self, from: usuarioData)
    return try await MetodoPagoDAO.readAllMetodosPago(of: usuario)
}

struct MetodosPagoView: View {
    @AppStorage("loggeduser") var usuarioData = Data()
    @Query(query: fetchMetodosPago) var metodosPago = []
    
    @State var selectedMetodoPago: MetodoPago? = nil
    
    //MARK: Toast state
    @State private var toastMessage: String = ""
    @State private var isShowingToast: Bool = false
    @State private var toastType: ToastType = .success
    
    var body: some View {
        ScrollView {
            VStack (spacing: 16) {
                RoundedButton(text: "Nuevo Método de Pago", systemImage: "creditcard") {
                    let nuevoMetodopago = MetodoPago()
                    selectedMetodoPago = nuevoMetodopago
                }
                .padding()
                if ($metodosPago.isLoading) {
                    LottieView(name: "loading")
                        .frame(width: 100, height: 100)
                }
                if (metodosPago.isEmpty) {
                        LottieView(name: "empty-metodosPago")
                            .frame(height: 300)
                            .padding()
                        Text("No hay Métodos de Pago registrados")
                            .font(.custom("Secular One", size: 24))
                }
                ForEach ($metodosPago.bindingValue) { metodoPago in
                    CardView(
                        card: metodoPago,
                        hideNumber: true,
                        isFLipped: .constant(false),
                        rotationDegrees: .constant(0.0)
                    )
                    .onTapGesture {
                        selectedMetodoPago = metodoPago.wrappedValue
                    }
                }
            }
            .padding(.horizontal)
            .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero)
        }
        .onAppear {
            $metodosPago.refetch()
        }
        //MARK: Modal
        .sheet(
            item: $selectedMetodoPago,
            onDismiss: {
                selectedMetodoPago = nil
                withAnimation {
                    metodosPago = metodosPago.filter({ metodo in
                        !metodo.id.isEmpty
                    })
                }
                $metodosPago.refetch()
            },
            content: { metodoPago in
                FormularioMetodoPagoView(
                    metodoPago: metodoPago,
                    refetch: $metodosPago.refetch,
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

struct MetodosPagoView_Previews: PreviewProvider {
    @State static var metodosPago = metodosPagoPreview
    
    static var previews: some View {
        MetodosPagoView(
            metodosPago: metodosPago
        )
    }
}
