//
//  LottieView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 3/9/2024.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let name: String
    let loopMode: LottieLoopMode
    let animationSpeed: CGFloat
    let contentMode: UIView.ContentMode = .scaleAspectFit
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView()
        let animation = LottieAnimation.named(name)
        animationView.animation = animation
        animationView.contentMode = contentMode
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
//            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
//            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
            animationView.topAnchor.constraint(equalTo: view.topAnchor), // Anchor to top
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor), // Anchor to bottom
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor), // Anchor to leading
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor) // Anchor to trailing
        ])
        return view }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }}
