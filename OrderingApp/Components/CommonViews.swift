//
//  CommonViews.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 01/07/22.
//

import SwiftUI

struct SectionHeader: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.custom("Secular One", size: 16))
    }
}

struct RoundedButton: View {
    var text: String
    var systemImage: String? = nil
    var color: Color = .accentColor
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            if systemImage == nil {
                Text(text)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(color)
                    .font(.custom("ABeeZee", size: 16))
                    .padding(10)
                    .background(.background)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke()
                            .foregroundColor(color)
                )
            } else {
                Label(text, systemImage: systemImage!)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(color)
                    .font(.custom("ABeeZee", size: 16))
                    .padding(10)            }
        }
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke()
                .foregroundColor(color)
            )
    }
}

struct RoundedTextField: View {
    var title: String
    @Binding var text: String
    
    var body: some View {
        TextField(title, text: $text)
            .font(.custom("ABeeZee", size: 16))
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke()
            )
    }
}

struct Campo<Content:View>: View {
    let content: Content
    var labelText: String
    var systemImage: String
    
    init (labelText: String, systemImage: String, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.labelText = labelText
        self.systemImage = systemImage
    }
    
    var body: some View {
        VStack(spacing: 5) {
            Label(labelText, systemImage: systemImage)
                .font(.custom("ABeeZee", size: 16))
            content
        }
    }
}

struct CommonViews: View {
    @State var isShowingToast = false
    
    var body: some View {
        VStack {
            RoundedTextField(title: "Ejemplo", text: .constant(""))
            Campo(labelText: "Ejemplo Campo", systemImage: "placeholdertext.fill") {
                RoundedTextField(title: "Ejemplo", text: .constant(""))
            }
            RoundedButton(text: "Toast") {
                isShowingToast = true
            }
            Spacer()
        }
        .toast(isPresented: $isShowingToast, text: "¡Método de pago agregado con éxito!", type: .success)
    }
}

struct CommonViews_Previews: PreviewProvider {
    static var previews: some View {
        CommonViews()
    }
}
