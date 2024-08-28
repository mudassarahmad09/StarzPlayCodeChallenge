//
//  VideoPlayerView.swift
//  BattleRap
//
//  Created by Qazi  Mudassar Tanveer on 14/03/2022.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {

    @State var isPlaying = false
    @State private var isLoading = true
    @State private var showControlls = true
    @State private var value: Float = 0.0
    @State private var player: AVPlayer
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    init(url: URL) {
        _player = State(wrappedValue: AVPlayer(url: url))
    }

    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                PlayerView(player: $player)

                if isLoading {
                    loaderView()
                }

                if showControlls {
                    Controls(player: $player,
                             isPlaying: $isPlaying,
                             pannel: $showControlls,
                             value: self.$value) {
                                                onback()
                    }
                }

            }.onTapGesture {
                showControlls.toggle()
            }

        }.background(Color.black.edgesIgnoringSafeArea(.all))
            .onAppear {
                self.rotate()
                self.player.play()
                self.isPlaying = true
            }
            .onChange(of: value) { _, newValue in
                if newValue > 0 {
                isLoading = false
                }

            }
    }

    func loaderView() -> some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .scaleEffect(3)
    }

    func rotate() {
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }

    func onback() {
        self.player.pause()
        self.isPlaying = false
        presentationMode.wrappedValue.dismiss()
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

    }
}

#Preview {
     VideoPlayerView(url: URL(string: AppUrl.VURL)!)
         .previewInterfaceOrientation(.landscapeRight)
}
