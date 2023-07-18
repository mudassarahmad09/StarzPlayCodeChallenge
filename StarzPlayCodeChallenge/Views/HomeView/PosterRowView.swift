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
                            let detailView = AppInstantiationFactory().tvDetailView(seasonId: title.id)
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

//struct PosterRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        PosterRowView()
//    }
//}
