//
//  VisualEffectRoundedCorner.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 07/11/2023.
//

import Foundation
import SwiftUI

struct VisualEffectRoundedCorner: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(16.0)
            .font(.subheadline)
            .bold()
            .foregroundColor(.white)
            .background(.ultraThinMaterial)
            .environment(\.colorScheme, .dark)
            .cornerRadius(15)
            .multilineTextAlignment(.center)
    }
}
