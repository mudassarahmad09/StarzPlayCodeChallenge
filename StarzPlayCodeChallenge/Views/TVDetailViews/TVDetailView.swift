//
//  TVDetailView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 08/09/2022.
//

import SwiftUI

struct TVDetailView: View {

    @State var isReadMoreExpanded = false

    var body: some View {
        loadView()

    }
}
//MARK: -  Load View
extension TVDetailView {
    func loadView() -> some View {
        VStack(spacing: 10){
            ZStack(alignment: .bottom){
                GradientImageView(image: CommonImage.placeHolder.rawValue)
                bannerImageView()
            }

            descripcationView()
            reactionView()

            SeasonGridView(selectedSeason: { season in
                print(season)
            })

            Spacer()
            
        }
        .background(.black)
    }
}
//MARK: -  Banner View Funcality
extension TVDetailView {
    func bannerImageView() -> some View {
        VStack(alignment:.leading, spacing: 15){

            nameAndTypeView()
            playableButtonView()


        }
        .padding([.trailing,.leading])
    }
    func nameAndTypeView() -> some View{
        VStack(alignment:.leading, spacing: 8){
            Text("Billons")
                .font(.largeTitle)
                .foregroundColor(.white)
            Text("2017 | 3 Seasons | R")
                .font(.system(size: 18, weight: .semibold, design: .default))
                .foregroundColor(.gray)
        }
    }

    func playableButtonView() -> some View {
        HStack(spacing: 8){
            
            PlayButton(action: {

            })

            Spacer()

            TrailerButton(action: {
                
            })

        }
    }
    func descripcationView() -> some View {
        VStack{
            ExpandableView("An LA vampire hunter has a week to come up with the cash to pay for his kid's tuition and braces. Trying to make a living these days just might kill him.")

        }
    }
}
//MARK: - Reaction View
extension TVDetailView {
    func reactionView() -> some View {
        HStack(alignment: .top, spacing: 12){
            RoundedButton(iconName: "plus", textName: "Watch List")
            RoundedButton(iconName: "hand.thumbsup", textName: "I like it")
            RoundedButton(iconName: "hand.thumbsdown",textName: "I don't like it")
            Spacer()
        }.padding([.trailing , .leading])
    }
}
struct TVDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TVDetailView()
        TVDetailView().preferredColorScheme(.dark)
    }
}
