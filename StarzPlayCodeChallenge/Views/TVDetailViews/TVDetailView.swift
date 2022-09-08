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
                .font(.system(size: 35, weight: .semibold, design: .default))
                .foregroundColor(.white)
            Text("2017 | 3 Seasons | R")
                .font(.system(size: 20, weight: .medium, design: .default))
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
        HStack(alignment: .top, spacing: 15){
            VStack{
                RoundedButton(iconName: "plus")
                Text("Watch List")
                    .foregroundColor(.gray)
            }
            VStack{
                RoundedButton(iconName: "hand.thumbsup")
                Text("I like it")
                    .foregroundColor(.gray)
            }
            VStack{
                RoundedButton(iconName: "hand.thumbsdown")
                Text("I don't like it")
                    .foregroundColor(.gray)
            }
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
