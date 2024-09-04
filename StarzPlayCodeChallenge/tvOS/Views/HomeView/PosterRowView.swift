//
//  PosterRowView.swift
//  StarzPlayCodeChallengeTV
//
//  Created by Qazi Mudassar on 04/09/2024.
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
     
     private func layoutScrollView() -> some View {
          ScrollView(.horizontal, showsIndicators: false) {
               LazyHStack(alignment: .top, spacing: 13) {
                    ForEach(layout.titles, id: \.id) { title in
                         PosterView(mediaItem: title)
                              
                    }
               }
               .padding(.horizontal, 13)
               .padding(.top, 10)
          }
          .scrollClipDisabled()
          .buttonStyle(.borderless)
     }
}

#Preview {
     PosterRowView(layout: Layout(sectionTitle: "Movie", titles: [MockMovie(), MockSeries() ,MockMovie(), MockSeries(), MockPerson()]))
          .previewLayout(.sizeThatFits)
          .preferredColorScheme(.dark)
}
