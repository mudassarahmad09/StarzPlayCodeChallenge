//
//  PlayerView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 10/09/2022.
//
import Foundation
import SwiftUI
import AVKit

struct PlayerView: UIViewControllerRepresentable {

    @Binding var player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {

        let controller = AVPlayerViewController()
        controller.player = player

        controller.showsPlaybackControls = false
        controller.videoGravity = .resize

        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {

    }

}
