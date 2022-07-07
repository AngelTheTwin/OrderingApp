//
//  Toast.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 04/07/22.
//

import SwiftUI

enum ToastType {
    case success
    case error
    case warning
}

struct ToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    let duration: TimeInterval
    var text: String
    var type: ToastType
    var systemImage: String {
        switch type {
        case .success:
            return "checkmark.square.fill"
        case .error:
            return "xmark.circle.fill"
        case .warning:
            return "exclamationmark.triangle.fill"
        }
    }
    var foregroundColor: Color {
        switch type {
        case .success:
            return .green
        case .error:
            return .red
        case .warning:
            return .yellow
        }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                VStack {
                    Spacer()
                    Label(text, systemImage: systemImage)
                        .font(.custom("ABeeZee", size: 16))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(foregroundColor)
                        .cornerRadius(10)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke()
//                                .foregroundColor(foregroundColor)
//                        )
                }
                .padding()
                .shadow(radius: 5)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation {
                            isShowing = false
                        }
                    }
                }
            }
        }
    }
}

extension View {
    func toast(isPresented: Binding<Bool>, text: String, type: ToastType, duration: TimeInterval = 2) -> some View {
        modifier(ToastModifier(isShowing: isPresented, duration: duration, text: text, type: type))
    }
}

struct Toast_Previews: PreviewProvider {
    @State static var showToast = false
    
    static var previews: some View {
        VStack {
            RoundedButton(text: "toast") {
                showToast = true
            }
        }
        .toast(isPresented: $showToast, text: "Success!", type: .success)
    }
}
