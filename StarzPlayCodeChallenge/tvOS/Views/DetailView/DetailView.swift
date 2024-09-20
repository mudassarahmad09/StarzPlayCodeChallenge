//
//  DetailView.swift
//  StarzPlayCodeChallengeTV
//
//  Created by Qazi Mudassar on 04/09/2024.
//

import SwiftUI

struct DetailView: View {
     var body: some View {
          ZStack(alignment: .top) {
              ScrollView {
                  ZStack(alignment: .bottom) {
                      GradientImageView(image: "tYLXJW1sZQU09VWY1BhSVPKGIwc.jpg")
                  }
              }
          }
          .edgesIgnoringSafeArea(.top)
     }
}

#Preview {
     DetailView()
}
