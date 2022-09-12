//
//  ControlView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 10/09/2022.
//

import SwiftUI
import AVKit

struct Controls: View {

    @Binding var player: AVPlayer
    @Binding var isPlaying: Bool
    @Binding var pannel: Bool
    @Binding var value: Float
    var didTapBack: (() -> Void)

    var body: some View {
        VStack {
            backBtn()

            Spacer()

            HStack {

                Button {
                    self.player.seek(to: CMTime(seconds: getSeconds() - 10, preferredTimescale: 1))
                } label: {
                    Image(systemName: "backward.fill")
                        .foregroundColor(.white)
                }

                Spacer()

                Button {

                    if isPlaying {
                        self.player.pause()
                    } else {
                        self.player.play()
                    }
                    isPlaying.toggle()

                } label: {

                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .foregroundColor(.white)
                }

                Spacer()

                Button {
                    self.player.seek(to: CMTime(seconds: getSeconds() + 10, preferredTimescale: 1))
                } label: {

                    Image(systemName: "forward.fill")
                        .foregroundColor(.white)
                }

            }
            .frame(width: 250)

            Spacer()

            VStack(alignment: .leading) {
                CustomProgressBar(player: $player, value: $value, isPlaying: $isPlaying)
                videoTime()
            }

        }
        .padding()
        .background(Color.black.opacity(0.4))
        .onTapGesture {
            self.pannel.toggle()
        }
        .onAppear {
            // this is a periodic time observer on player which call its self after 1 sec
            self.player.addPeriodicTimeObserver(
                forInterval: CMTime(
                    seconds: 1,
                    preferredTimescale: 1
                ),
                queue: .main
            ) { (_) in
                self.value = getSliderValue()
                if self.value == 1.0 {
                    self.isPlaying = false
                }
            }
        }
    }

    func backBtn() -> some View {
        HStack {
            Button {
                self.didTapBack()
            } label: {
                Image(systemName: "x.circle.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
            }
            Spacer()
        }
    }

    func getSliderValue() -> Float {
        return Float(self.player.currentTime().seconds / (self.player.currentItem?.duration.seconds)!)
    }

    func getSeconds() -> Double {
        return Double(Double(self.value) * (self.player.currentItem?.duration.seconds)!)
    }

    func videoTime() -> some View {
        HStack(spacing: 1) {
            Text("\( secondsToHoursMinutesSeconds(secondsInDouble: getSeconds()) ) ")
            Text("/")
            Text("\(secondsToHoursMinutesSeconds(secondsInDouble: (self.player.currentItem?.duration.seconds)!))")
        }
        .foregroundColor(.white)

    }

    func secondsToHoursMinutesSeconds(secondsInDouble: Double) -> String {
        let seconds = ((secondsInDouble.isNaN) ? 0 : Int(secondsInDouble))
        let hours = String(format: "%02d", Int(seconds / 3600))
        let mintus = String(format: "%02d", Int((seconds % 3600) / 60))
        let second = String(format: "%02d", Int((seconds % 3600) % 60))
        return "\(hours):\(mintus):\(second)"
    }
}
struct Controls_Previews: PreviewProvider {

    static var previews: some View {
        Controls(player: .constant(AVPlayer(url: URL(string: AppUrl.VURL)!)),
                 isPlaying: .constant(true),
                 pannel: .constant(true),
                 value: .constant(0.58),
                 didTapBack: {
                    print("back button is pressed")
        })
            .background(Color.black)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
