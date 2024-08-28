//
//  ExpandableView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 08/09/2022.
//

import SwiftUI

struct ExpandableView: View {

    @State private var expanded: Bool = false
    @State private var truncated: Bool = false
    private var text: String

    init(_ text: String) {
        self.text = text
    }

    private func determineTruncation(_ geometry: GeometryProxy) {
        let total = self.text.boundingRect(
            with: CGSize(
                width: geometry.size.width,
                height: .greatestFiniteMagnitude
            ),
            options: .usesLineFragmentOrigin,
            attributes: [.font: UIFont.systemFont(ofSize: 16)],
            context: nil
        )

        if total.size.height > geometry.size.height {
            self.truncated = true
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(self.text)
                .font(.system(size: 16))
                .lineLimit(self.expanded ? nil : 3)
                .foregroundColor(.gray)
                .background(GeometryReader { geometry in
                    Color.clear.onAppear {
                        self.determineTruncation(geometry)
                    }
                })

            if self.truncated {
                self.toggleButton
            }
        }
        .padding(.top, 10)
        .padding([.trailing, .leading])
        .background(.black)
    }

    var toggleButton: some View {
        Button(action: {
            self.expanded.toggle()
        }, label: {
            Text(self.expanded ? "Read less" : "Read more")
                .font(.caption)
                .foregroundColor(Color(CommonColor.button.rawValue))
        })
    }
}

#Preview {
     ExpandableView("An LA vampire hunter has a week to come up with the cash to pay for his kid's tuition and braces. Trying to make a living these days just might kill him.")
         .previewLayout(PreviewLayout.sizeThatFits)
         .preferredColorScheme(.dark)
}
