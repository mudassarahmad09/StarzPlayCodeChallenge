//
//  CustomProgressBar.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 10/09/2022.
//

import Foundation

import SwiftUI
import AVKit

struct CustomProgressBar: UIViewRepresentable {

    @Binding var player: AVPlayer
    @Binding var value: Float
    @Binding var isPlaying: Bool


    func makeCoordinator() -> Coordinator {
        return CustomProgressBar.Coordinator(parent1: self)
    }

    func makeUIView(context: Context) -> UISlider {

        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .gray
        slider.thumbTintColor = .red
        slider.setThumbImage(UIImage(named: CommonImage.ellipse.rawValue), for: .normal)
        slider.value = value
        slider.addTarget(context.coordinator, action: #selector(context.coordinator.changed(slider:)), for: .valueChanged)
        // adding the loader
        return slider

    }

    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = value
    }


    class Coordinator: NSObject {

        var parent: CustomProgressBar

        init(parent1: CustomProgressBar) {
            parent = parent1
        }

        @objc func changed(slider: UISlider) {

            if slider.isTracking {

                parent.player.pause()
                let sec = Double(slider.value * Float((parent.player.currentItem?.duration.seconds)!))
                parent.player.seek(to: CMTime(seconds: sec, preferredTimescale:  1))

            } else {

                let sec = Double(slider.value * Float((parent.player.currentItem?.duration.seconds)!))
                parent.player.seek(to: CMTime(seconds: sec, preferredTimescale:  1))

                if parent.isPlaying {
                    parent.player.play()
                }

            }
        }
    }
}
