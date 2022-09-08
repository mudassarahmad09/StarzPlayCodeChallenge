//
//  NavbarHiddenView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 08/09/2022.
//

import SwiftUI

struct HideNavbarOf<Content: View>: View {
    var view: Content

    var body: some View {
        view
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

struct NavbarHiddenView_Previews: PreviewProvider {

    static var previews: some View {
        HideNavbarOf(view: TVDetailView())
    }
}
