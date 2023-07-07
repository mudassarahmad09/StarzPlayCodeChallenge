//
//  SeasonGridCell.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 07/07/2023.
//

import SwiftUI

struct SeasonGridCell: View {
    
    let geometryReader: GeometryProxy
    let season: Season
    let action: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        action()
                    }
                    
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
                
            }.frame(width: geometryReader.size.width/3)
            
            Divider()
                .frame(width: geometryReader.size.width/3, height: season.isSelecte ? 2.5 : 0)
                .overlay(.white)
            
        }.frame(height: 50, alignment: .top)
    }
}
