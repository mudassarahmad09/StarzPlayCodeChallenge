//
//  PosterRowView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 18/07/2023.
//

import SwiftUI

struct PosterRowView: View {
    let layout: Layout
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(layout.sectionTitle)
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                Spacer()
            }.padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 13) {
                    ForEach(layout.titles, id: \.id) { title in
                        NavigationLink {
                            let detailView = AppInstantiationFactory().detailView(for: title.id, and: title.getMediaContentType())
                            HideNavbarOf(view: detailView)
                        } label: {
                            PosterView(mediaItem: title)
                        }
                    }
                }
                .padding(.horizontal, 13)
                .padding(.top, 10)
            }
        }
    }
}

struct PosterRowView_Previews: PreviewProvider {
    static var previews: some View {
        PosterRowView(layout: Layout(sectionTitle: "Movie", titles: [MockMovie(),MockSeries(),MockMovie(),MockSeries()]))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
    
    private struct MockMovie: MediaAttributes {
        var id: Int = Int.random(in: 1...Int.max)
        func getMediaTitle() -> String { "Title" }
        func getMediaSubTitle() -> String { "SubTitle" }
        func getMediaImagePoster() -> String { "/stTEycfG9928HYGEISBFaG1ngjM.jpg"}
        func getMediaContentType() -> ContentType { .movie }
    }
    
    private struct MockSeries: MediaAttributes {
        var id: Int = Int.random(in: 1...Int.max)
        func getMediaTitle() -> String { "Title" }
        func getMediaSubTitle() -> String { "SubTitle" }
        func getMediaImagePoster() -> String { "/oFGMGn1ywvvYobxOcPKVytN3AQK.jpg"}
        func getMediaContentType() -> ContentType { .movie }
    }
}
