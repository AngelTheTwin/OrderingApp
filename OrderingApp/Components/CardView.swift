//
//  CardView.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 30/06/22.
//

import SwiftUI

extension MetodoPago {
    var type: CreditCardType? {
        return CreditCardValidator(numeroTarjeta).type
    }
}

extension String {
    func inserting(separator: String, every n: Int) -> String {
        var result: String = ""
        let characters = Array(self)
        stride(from: 0, to: characters.count, by: n).forEach {
            result += String(characters[$0..<min($0+n, characters.count)])
            if $0+n < characters.count {
                result += separator
            }
        }
        return result
    }
}

struct CardView: View {
    @Binding var card: MetodoPago
    var hideNumber: Bool
    @Binding var isFLipped: Bool
    @Binding var rotationDegrees: Double
    
    var body: some View {
        CardBiulder {
            ZStack {
                CardFront(card: $card, hideNumber: hideNumber)
                if (isFLipped) {
                    CardBack(card: $card)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 0.1)
            )
            .rotation3DEffect(.degrees(rotationDegrees), axis: (x: 0.0, y: 1.0, z: 0.0))
        }
    }
}

struct CardBiulder<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .shadow(color: Color(red: 217/255.0, green: 217/255.0, blue: 217/255.0, opacity: 0.300), radius: 5.0, x: 2, y: 2.0)
    }
}

struct CardFront: View {
    @Binding var card: MetodoPago
    var hideNumber: Bool
    
    var formattedCardNumber: String {
        var charGroupNumbber = 1
        var count = 0
        var result = ""
        card.numeroTarjeta.forEach { char in
            result.append(
                charGroupNumbber > 3
                ? char
                : hideNumber ? "*" : char
            )
            count += 1
            if (count > 3) {
                result.append(" ")
                count = 0
                charGroupNumbber += 1
            }
        }
        return result
    }
    
    var cardProviderLogo: String {
        switch card.type {
        case .amex:
            return "AmericanExpress-logo"
        case .visa:
            return "Visa-logo"
        case .masterCard:
            return "Mastercard-logo"
        case .maestro:
            return "Maestro-logo"
        case .dinersClub, .jcb, .discover, .unionPay, .mir, .none:
            return "CreditCard"
        }
    }
    
    var formattedExpiry: String {
        return card.vigencia.inserting(separator: "/", every: 2)
    }
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 70, height: 50)
                        .foregroundColor(Color(hex: "#D9D9D9"))
                    Spacer()
                }
                Spacer()
                HStack {
                    VStack (alignment: .leading, spacing: 0) {
                        Spacer()
                        Text(formattedCardNumber.isEmpty ? "CARD NUMBER" :  formattedCardNumber)
                            .textContentType(.creditCardNumber)
                            .font(.custom("ABeeZee", size: 16))
                        Spacer()
                        Text(!card.titular.isEmpty ? card.titular.uppercased() : "CARD HOLDER NAME")
                            .font(.custom("ABeeZee", size: 16))
                    }
                    Spacer()
                }
            }
            Spacer()
            VStack {
                Image(cardProviderLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                    .shadow(color: Color(red: 217/255.0, green: 217/255.0, blue: 217/255.0, opacity: 0.300), radius: 2, x: 0, y: 0)
                Spacer()
                Text(formattedExpiry.isEmpty ? "EXPIRY" : formattedExpiry)
                    .font(.custom("ABeeZee", size: 16))
            }
        }
        .padding()
        .frame(width: 300, height: 180)
        .background(.background)
        .cornerRadius(10)
    }
}

struct CardBack: View {
    @Binding var card: MetodoPago
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(minWidth: .zero, maxWidth: .infinity)
                .frame(height: 40)
                .padding(.top, 20)
            HStack {
                HStack {
                    Spacer()
                    Text(card.cvv)
                        .font(.custom("ABeeZee", size: 16))
                        .padding()
                }
                .frame(width: 150, height: 40, alignment: .leading)
                .background(Color(red: 108/255.0, green: 108/255.0, blue: 108/255.0))
                .padding(.horizontal)
                Spacer()
            }
            Spacer()
        }
        .frame(width: 300, height: 180)
        .background(.background)
        .cornerRadius(10)
        .rotation3DEffect(.degrees(180.0), axis: (x: 0.0, y:1.0, z:0.0))
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(
            card: .constant(cardPreview1),
            hideNumber: false,
            isFLipped: .constant(false),
            rotationDegrees: .constant(0.0)
        )
        .preferredColorScheme(.dark)
    }
}
