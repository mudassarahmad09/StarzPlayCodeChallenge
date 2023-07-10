//
//  SeasonGridView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 09/09/2022.
//

import SwiftUI

struct SeasonGridView: View {

    @ObservedObject private var viewModel: SeasonGridVM
    @State var selectedValue = false
    private var selectedSeason: (_ season: Season) -> Void

    init(
        viewModel: SeasonGridVM,
        selectedSeason: @escaping (_ season: Season) -> Void
    ) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self.selectedSeason = selectedSeason
    }

    var body: some View {
        GeometryReader { geometryReader in
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack {
                    ForEach(viewModel.seasons, id: \.self) { season in
                        SeasonGridCell(geometryReader: geometryReader,
                                       season: season) {
                            viewModel.update(selecteItem: season)
                            selectedSeason(viewModel.getUpdatedValue() ?? season)
                        }
                    }
                }
            })
        }
        .animation(.linear, value: viewModel.getUpdatedValue())
        .padding(.top, 18)
        .frame( height: 50)
        .background(.black)
    }
}

struct SeasonGridView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TestSeasonGridView()
                .previewLayout(PreviewLayout.sizeThatFits)
            
            TestSeasonGridView()
                .previewLayout(PreviewLayout.sizeThatFits)
                .previewDevice("iPhone 12 mini")
                .preferredColorScheme(.dark)
        }
    }
    
    private struct TestSeasonGridView: View {
        var body: some View {
            let mockSeasons = [
                Season(name: "SEASON 1", isSelected: true),
                Season(name: "SEASON 2", isSelected: false),
                Season(name: "SEASON 3", isSelected: false),
                Season(name: "SEASON 4", isSelected: false)
            ]
            let gridVM = SeasonGridVM(seasons: mockSeasons)
            SeasonGridView(viewModel: gridVM, selectedSeason: { _ in })
        }
    }
}

