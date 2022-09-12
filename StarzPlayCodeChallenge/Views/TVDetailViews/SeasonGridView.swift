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
    ){
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self.selectedSeason = selectedSeason
    }

    var body: some View {
        GeometryReader { gp in
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack {
                    ForEach(viewModel.seasons, id: \.self) { season in
                        VStack {
                            HStack {
                                Spacer()
                                Button(action: {
                                    withAnimation {
                                        viewModel.update(selecteItem: season)
                                    }

                                    selectedSeason(viewModel.getUpdatedValue() ?? season)
                                }, label: {
                                    HStack {
                                        Text(season.name)
                                            .font(.system(size: 18, weight: .bold, design: .default))
                                            .foregroundColor(season.isSelecte ? .white : .gray)

                                    }
                                })

                                Spacer()
                                Text(" |")
                                    .font(.system(size: 18, weight: .bold, design: .default))
                                    .foregroundColor(.white)

                            }.frame(width: gp.size.width/3)

                            Divider()
                                .frame(width: gp.size.width/3, height: season.isSelecte ? 2.5 : 0)
                                .overlay(.white)

                        }.frame(height: 50, alignment: .top)
                    }
                }

            })

        }
        .animation(.easeOut, value: viewModel.getUpdatedValue())
        .padding(.top, 18)
        .frame( height: 50)
        .background(.black)
    }
}
struct SeasonGridView_Previews: PreviewProvider {
    static var previews: some View {

         let mockSeasons = [Season(name: "SEASON 1", isSelected: true), Season(name: "SEASON 2", isSelected: false), Season(name: "SEASON 3", isSelected: false), Season(name: "SEASON 4", isSelected: false)]

        SeasonGridView(viewModel: SeasonGridVM(seasons: mockSeasons), selectedSeason: {_ in

        })
        .previewLayout(PreviewLayout.sizeThatFits)
        SeasonGridView(viewModel: SeasonGridVM(seasons: mockSeasons), selectedSeason: {_ in

        })
        .previewDevice("iPhone 12 mini")
        .preferredColorScheme(.dark)
    }
}
