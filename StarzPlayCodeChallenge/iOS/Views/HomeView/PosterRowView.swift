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
               titleView()
               layoutScrollView()
          }
     }
     
     private func titleView() -> some View {
          HStack {
               Text(layout.sectionTitle)
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
               Spacer()
          }.padding(.horizontal)
     }
     
     private func layoutScrollView() -> ScrollView<some View> {
          ScrollView(.horizontal, showsIndicators: false) {
               LazyHStack(alignment: .top, spacing: 13) {
                    ForEach(layout.titles, id: \.id) { title in
                         PosterView(mediaItem: title)
                              .toDetailsView(title)
                    }
               }
               .padding(.horizontal, 13)
               .padding(.top, 10)
          }
     }
}

#Preview(traits: .sizeThatFitsLayout) {
     PosterRowView(layout: Layout(sectionTitle: "Movie", titles: [MockMovie(), MockSeries() ,MockMovie(), MockSeries(), MockPerson()]))
          .preferredColorScheme(.dark)
     
}
