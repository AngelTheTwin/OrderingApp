//
//  LoginView.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 28/06/22.
//

import SwiftUI

struct LoginData: Codable {
    var correo: String = ""
    var contraseña: String = ""
}

struct LoginView: View {
    @AppStorage("correo") var correo = ""
    @State var contraseña = ""
    @State var showMensajeError = false
    @State var mensajeError = ""
    @AppStorage("loggeduser") var loggedUser: Data = Data()
    
    var body: some View {
        VStack (spacing: 12) {
            Text("Iniciar Sesión")
                .font(.custom("Secular One", size: 36.0))
            TextField("Correo", text: $correo)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .font(.custom("AbeeZee", size: 20.0))
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.secondary, lineWidth: 1.5)
                )
            SecureField("Contraseña", text: $contraseña)
                .font(.custom("AbeeZee", size: 20.0))
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.secondary, lineWidth: 1.5)
                )
            if (showMensajeError) {
                Text(mensajeError)
                    .font(.custom("ABeeZee", size: 14, relativeTo: .caption))
                    .foregroundColor(Color(hex: "C40B0B"))
            }
            Button {
                Task {
                    await login()
                }
            } label: {
                Text("Iniciar Sesión")
                    .padding(12)
                    .font(.custom("ABeeZee", size: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.secondary, lineWidth: 2)
                    )
            }
        }
        .padding()
    }
    
    private func login() async {
        let usuario = LoginData(correo: correo, contraseña: contraseña)
        do {
            withAnimation {
                showMensajeError = false
            }
            guard correo != "" else {
                withAnimation {
                    mensajeError = "Proporcione un correo."
                    showMensajeError = true
                }
                return
            }
            guard contraseña != "" else {
                withAnimation {
                    mensajeError = "Proporcione una contraseña."
                    showMensajeError = true
                }
                return
            }
            let loggedUsuario = try await UsuarioDAO.login(usuario)
            self.loggedUser = try! JSONEncoder().encode(loggedUsuario)
        }
        catch RequestError.wrongCredentials(let mensaje) {
            withAnimation {
                mensajeError = mensaje
                showMensajeError = true
            }
        }
        catch {
            print("Error Login", error)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
