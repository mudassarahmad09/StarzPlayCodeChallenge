//
//  LazyView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 28/08/2024.
//

import SwiftUI

struct LazyView<Content: View>: View {
     let build: () -> Content
     
     init(_ build: @autoclosure @escaping () -> Content) {
          self.build = build
     }
     
     var body: Content {
          build()
     }
}
