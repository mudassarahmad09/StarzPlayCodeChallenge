//
//  PosterGridView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 11/07/2023.
//

import SwiftUI

struct PosterGridView: View {
    let data = (1...100).map { "Item \($0)" }
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 3) , spacing: 10) {
                ForEach(data, id: \.self) {_ in
                    //PosterView(tvShow: <#TVShows#>)
                }
            }
        }
    }
}

struct PosterGridView_Previews: PreviewProvider {
    static var previews: some View {
        PosterGridView()
    }
}
