//
//  HomeView.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 28/06/22.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("loggeduser") private var user = Data()
    @State var carrito: [Orden] = []
    
    var body: some View {
        ZStack {
            TabView {
                //MARK: Ordenar
                NavigationView {
                    OrdenarView(
                        agregarACarrito: agregarACarrito
                    )
                    .navigationTitle("Ordenar")
                    .toolbar {
                        Button {
                            logOut()
                        } label: {
                            Image(systemName: "escape")
                        }
                    }
                }
                .tabItem {
                    Image(systemName: "takeoutbag.and.cup.and.straw")
                    Text("Ordenar")
                }
                
                //MARK: Carrito
                NavigationView {
                    CarritoView(
                        carrito: $carrito,
                        eliminarOrden: eliminarDeCarrito,
                        vaciarCarrito: vaciarCarrito
                    )
                    .navigationTitle("Carrito")
                    .toolbar {
                        Button {
                            logOut()
                        } label: {
                            Image(systemName: "escape")
                        }
                    }
                }
                .badge(carrito.count)
                .tabItem {
                    Image(systemName: "cart")
                    Text("Carrito")
                }
                
                //MARK: Pedidos
                NavigationView {
                    PedidosView()
                        .navigationTitle("Pedidos")
                        .toolbar {
                            Button {
                                logOut()
                            } label: {
                                Image(systemName: "escape")
                            }
                        }
                }
                .tabItem {
                    Image(systemName: "checklist")
                    Text("Pedidos")
                }
                
                //MARK: Direcciones
                NavigationView {
                    DireccionesView()
                    .navigationTitle("Direcciones")
                    .toolbar {
                        Button {
                            logOut()
                        } label: {
                            Image(systemName: "escape")
                        }
                    }
                }
                .tabItem {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Direcciones")
                }
                //MARK: Metodos de Pago
                NavigationView {
                    MetodosPagoView()
                    .navigationTitle("Métodos de Pago")
                    .toolbar {
                        Button {
                            logOut()
                        } label: {
                            Image(systemName: "escape")
                        }
                    }
                }
                .tabItem {
                    Image(systemName: "creditcard")
                    Text("Métodos de Pago")
                }
            }
            .navigationViewStyle(.stack)
        }
    }
    
    
    func agregarACarrito(_ orden: Orden) {
        var found = false
        carrito = carrito.map({ ordenCarrito in
            if (ordenCarrito.platillo._id == orden.platillo._id) {
                found = true
                let nuevaCantidad = ordenCarrito.cantidad + orden.cantidad
                var nuevasInstrucciones = ""
                if ordenCarrito.instruccionesEspeciales.isEmpty {
                    nuevasInstrucciones += orden.instruccionesEspeciales
                } else {
                    nuevasInstrucciones = "\(ordenCarrito.instruccionesEspeciales), \(orden.instruccionesEspeciales)"                }
                return Orden(platillo: orden.platillo, cantidad: nuevaCantidad, instruccionesEspeciales: nuevasInstrucciones)
            }
            return ordenCarrito
        })
        
        if (!found) {
            carrito.append(orden)
        }
    }
    
    func eliminarDeCarrito(_ orden: Orden) {
        withAnimation {
            carrito = carrito.filter { ordenCarrito in
                return orden.id != ordenCarrito.id
            }
        }
    }
    
    func vaciarCarrito() {
        withAnimation {
            carrito = []
        }
    }
    
    func logOut() {
        user = Data()
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
            .previewDevice("iPhone 13 Pro")
    }
}
