//
//  OrdenarView.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 29/06/22.
//

import SwiftUI

struct OrdenarView: View {
    @Query(query: ProductoDAO.getAllProductosGroupedByCategoria) var categorias = []
    var agregarACarrito: (Orden) -> Void
    
    @State var showToast = false
    @State var toastMessage = ""
    @State var toastType: ToastType = .success
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("¿De qué tienes antojo?")
                        .font(.custom("Secular One", size: 30))
                    Spacer()
                }
                .padding()
                if $categorias.isLoading {
                    LottieView(name: "loading")
                        .frame(width: 100, height: 100)
                }
                if !categorias.isEmpty {
                    VStack {
                        ForEach (categorias) {categoria in
                            CategoriaView(
                                categoria: categoria,
                                agregarACarrito: agregarACarrito
                            )
                        }
                    }
                }
                if let error = $categorias.error {
                    Spacer()
                        .onAppear {
                            showToast = true
                            toastMessage = error.localizedDescription
                            toastType = .error
                        }
                }
                Spacer()
            }
        }
        .onAppear {
            $categorias.refetch()
        }
        .toast(isPresented: $showToast, text: toastMessage, type: toastType)
    }
}

struct OrdenarView_Previews: PreviewProvider {
    static var agregarACarrito: (Orden) -> Void = { _ in }
    
    static var previews: some View {
        OrdenarView(categorias: [categoriaPreview], agregarACarrito: agregarACarrito)
    }
}
