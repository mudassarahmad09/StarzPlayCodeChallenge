//
//  SeasonGridView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 09/09/2022.
//

import SwiftUI

struct SeasonGridView: View {

    @ObservedObject private var viewModel = SeasonGridVM()
    var selectedSeason: (_ season: Season) -> Void

    var body: some View {
        GeometryReader { gp in
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack {
                    ForEach(viewModel.seasons, id: \.self) { season in
                        VStack{
                            HStack{

                                Button(action: {
                                    withAnimation{
                                        viewModel.update(selecteItem: season)
                                    }
                                    selectedSeason(viewModel.seasons.first(where: {$0.isSelecte == true}) ?? season)
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

                        }.frame(height: 50,alignment:.top)
                    }
                }

            })

        }
        .padding([.leading ,.trailing])
        .padding(.top , 20)
        .frame( height: 50)
        .background(.black)

    }

}


struct SeasonGridView_Previews: PreviewProvider {
    static var previews: some View {


        SeasonGridView(selectedSeason:{_ in

        } )
        .previewLayout(PreviewLayout.sizeThatFits)
        SeasonGridView(selectedSeason:{_ in

        } )
        .preferredColorScheme(.dark)
        .previewLayout(PreviewLayout.sizeThatFits)

    }
}

