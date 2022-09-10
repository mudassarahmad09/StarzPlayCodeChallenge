//
//  SeasonGridView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 09/09/2022.
//

import SwiftUI

struct SeasonGridView: View {

    @ObservedObject private var viewModel: SeasonGridVM
    private var selectedSeason: (_ season: Season) -> Void

    @State var selectedValue = false

    init(viewModel: SeasonGridVM, selectedSeason: @escaping (_ season: Season) -> Void) {
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

                                Button(action: {
                                    withAnimation {
                                        viewModel.update(selecteItem: season)
                                    }

                                    selectedSeason(viewModel.getUpdatedValue() ?? season)
                                }, label: {
                                    Text(season.name)
                                        .font(.system(size: 18, weight: .bold, design: .default))
                                        .foregroundColor(.white)

                                    Text(" | ")
                                        .font(.system(size: 18, weight: .bold, design: .default))
                                        .foregroundColor(.white)

                                })

                            }.frame(width: gp.size.width/3)

                            if season.isSelecte {
                                Divider()
                                    .frame(width: gp.size.width/3, height: 2)
                                    .overlay(.white)
                            }

                        }.frame(height: 50, alignment: .top)
                    }
                }

            })

        }
        .padding([.leading, .trailing])
        .padding(.top, 20)
        .frame( height: 50)
        .background(.black)

    }

}

//struct SeasonGridView_Previews: PreviewProvider {
//    static var previews: some View {
//
//      let seasons = [Season(name: "SEASON 1", isSelecte: true), Season(name: "SEASON 2", isSelecte: false), Season(name: "SEASON 3", isSelecte: false), Season(name: "SEASON 4", isSelecte: false)]
//
//        SeasonGridView(viewModel: SeasonGridVM(seasons: seasons), selectedSeason: {_ in
//
//        })
//        .previewLayout(PreviewLayout.sizeThatFits)
//        SeasonGridView(viewModel: SeasonGridVM(seasons: seasons), selectedSeason: {_ in
//
//        })
//        .preferredColorScheme(.dark)
//        .previewLayout(PreviewLayout.sizeThatFits)
//
//    }
//}
