//
//  DireccionView.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 29/06/22.
//

import SwiftUI

struct DireccionView: View {
    var direccion: Direccion
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .font(.custom("ABeeZee", size: 28))
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.red)
                Text(direccion.titular.isEmpty ? "Titular" : direccion.titular)
                    .font(.custom("ABeeZee", size: 22))
            }
            
            VStack {
                Text(direccion.calle.isEmpty ? "Calle" : direccion.calle)
                    .font(.custom("ABeeZee", size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(direccion.colonia.isEmpty ? "Colonia" : direccion.colonia)
                    .font(.custom("ABeeZee", size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(direccion.ciudad.isEmpty ? "Ciudad" : direccion.ciudad)
                    .font(.custom("ABeeZee", size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(direccion.codigoPostal.isEmpty ? "Código Postal" : direccion.codigoPostal)
                    .font(.custom("ABeeZee", size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(direccion.contacto.isEmpty ? "Teléfono de Contacto" : direccion.contacto)
                    .font(.custom("ABeeZee", size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .frame(width: 280)
        .padding()
        .background(.background)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 0.3)
        )
    }
}

struct DireccionView_Previews: PreviewProvider {
    @State static var direccion = direccionPreview1
    
    static var previews: some View {
        DireccionView(direccion: direccion)
    }
}
