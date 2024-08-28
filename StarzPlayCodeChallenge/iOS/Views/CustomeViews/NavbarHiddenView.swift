//
//  NavbarHiddenView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 08/09/2022.
//

import SwiftUI

struct HideNavbarOf<Content: View>: View {
    var view: Content

    var body: some View {
        view
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .preferredColorScheme(.dark)
    }
}
