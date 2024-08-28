//
//  LoadingIndicatorView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 07/07/2023.
//

import SwiftUI

struct LoadingIndicatorView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .scaleEffect(2)
            .zIndex(1)
    }
}

#Preview {
     LoadingIndicatorView()
}
