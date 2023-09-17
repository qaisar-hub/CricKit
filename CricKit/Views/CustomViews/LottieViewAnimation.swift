//
//  LottieViewAnimation.swift
//  CricKit
//
//  Created by ephrim.daniel on 17/09/23.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
	
	var name = "boundary"
	var loopMode: LottieLoopMode = .playOnce
	
	static let shared = LottieView()
	let animationView = LottieAnimationView()
	
	func makeUIView(context: Context) -> UIView {
		let view = UIView(frame: .zero)
		
		let animationView = LottieAnimationView(name: name, bundle: Bundle.main)
		animationView.loopMode = loopMode
		animationView.play()
		
		view.addSubview(animationView)
		
		animationView.translatesAutoresizingMaskIntoConstraints = false
		animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
		animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
		return view
		
	}
	
	func updateUIView(_ uiView: UIViewType, context: Context) {
		
	}
}

struct ShowLottieAnimation: View {
	
	var ballState: Character?
	
	var body: some View {
		switch ballState {
		case "4":
			LottieView(name: "boundary", loopMode: .playOnce)
		case "6":
			LottieView(name: "sixer", loopMode: .playOnce)
		case "W":
			LottieView(name: "out", loopMode: .playOnce)
		default:
			Text("")
		}
	}
}
