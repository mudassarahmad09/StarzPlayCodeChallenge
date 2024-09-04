//
//  PosterView.swift
//  StarzPlayCodeChallengeTV
//
//  Created by Qazi Mudassar on 04/09/2024.
//

import SwiftUI

struct PosterView: View {
     let mediaItem: MediaAttributes
     let width: CGFloat = 250
     let height: CGFloat = 375
     let alpha: CGFloat = 0.45
     
     var body: some View {
          Button {} label: {
               VStack(alignment: .leading) {
                    
                    AsyncImageView(url:
                                        URL(string: AppUrl.IMAGEURL + (mediaItem.getMediaImagePoster() ))!,
                                   placeHolder: .placeHolder,
                                   width: width,
                                   height: height)

                    VStack(alignment: .leading, spacing: 3) {
                         Text(mediaItem.getMediaTitle())
                              .foregroundColor(.white)
                         
                         Text(mediaItem.getMediaSubTitle())
                              .foregroundColor(.white)
                         
                    }
                    .frame(minHeight: height * alpha, alignment: .top)
               }
               .frame(width: width)
          }
          .buttonStyle(.borderless)
     }
}

#Preview {
     
     PosterView(mediaItem: MockMovie())
         .previewLayout(.sizeThatFits)
         .preferredColorScheme(.dark)
}
