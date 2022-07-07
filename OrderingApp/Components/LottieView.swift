//
//  LottieView.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 04/07/22.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var name: String
    var loopMode: LottieLoopMode = .loop

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)

        let animationView = AnimationView()
        let animation = Animation.named(name)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView(name: "empty-cart")
    }
}
