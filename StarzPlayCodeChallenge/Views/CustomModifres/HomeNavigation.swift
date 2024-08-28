//
//  HomeNavigation.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 28/08/2024.
//

import SwiftUI

extension View {
     @ViewBuilder
     func toDetailsView(_ title: any MediaAttributes) -> some View {
          NavigationLink {
               LazyView(
                    AppInstantiationFactory().detailView(
                         for: title.id,
                         and: title.getMediaContentType()
                    )
               )
          } label: {
               PosterView(mediaItem: title)
          }
     }
     
}
