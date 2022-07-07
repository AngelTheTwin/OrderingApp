//
//  CategoriaView.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 29/06/22.
//

import SwiftUI

struct CategoriaView: View {
    var categoria: Categoria
    var agregarACarrito: (Orden) -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text(categoria.nombre)
                    .font(.custom("Secular One", size: 20))
                Spacer()
            }
            .padding(.horizontal)
            HStack {
                Text(categoria.descripcion)
                    .font(.custom("Secular One", size: 16))
                    .foregroundColor(Color("AccentColor2"))
                Spacer()
            }
            .padding(.horizontal)
            ScrollView (.horizontal) {
                HStack {
                    ForEach (categoria.productos, id: \.self._id) {platillo in
                        PlatilloView(
                            platillo: platillo,
                            agregarACarrito: agregarACarrito
                        )
                    }
                }
            }
            .safeAreaInset(edge: .leading) {
                EmptyView()
                    .frame(width: 0)
            }
        }
    }
}

struct CategoriaView_Previews: PreviewProvider {
    static var agregarACarrito: (Orden) -> Void = { _ in }
    
    static var previews: some View {
        CategoriaView(
            categoria: categoriaPreview,
            agregarACarrito: agregarACarrito
        )
    }
}
