//
//  PosterView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 18/07/2023.
//

import SwiftUI

struct PosterView: View {
    let mediaItem: MediaAttributes
    let width: CGFloat = 110
    let height: CGFloat = 160
    let alpha: CGFloat = 0.45
    
    var body: some View {
        VStack(alignment: .leading) {
            
            AsyncImageView(url:
                            URL(string: AppUrl.IMAGEURL + (mediaItem.getMediaImagePoster() ))!,
                           placeHolder: .placeHolder,
                           width: width,
                           height: height)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(mediaItem.getMediaTitle())
                    .foregroundColor(.white)
                    .font(.headline)
                    .lineLimit(2)
                Text(mediaItem.getMediaSubTitle())
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .lineLimit(1)
                
            }
            .frame(minHeight: height * alpha, alignment: .top)
        }
        .frame(width: width)
    }
}

struct PosterView_Previews: PreviewProvider {
    static var previews: some View {
        PosterView(mediaItem: MockMovie())
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}

