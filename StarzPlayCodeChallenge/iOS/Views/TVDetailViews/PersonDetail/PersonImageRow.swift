//
//  PersonImageRow.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 10/08/2023.
//

import SwiftUI

struct PersonImageRow: View {
    let images: [Profile]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Images")
                .font(.title3)
                .bold()
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(images) { profile in
                        AsyncImageView(url:
                                        URL(string: AppUrl.IMAGEURL + (profile.filePath))!,
                                       placeHolder: .placeHolder,
                                       width: 110,
                                       height: 220)
                    }
                }
            }
        }
    }
}
