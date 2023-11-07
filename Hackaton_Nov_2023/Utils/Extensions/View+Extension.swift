//
//  View+Extension.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 07/11/2023.
//

import Foundation
import SwiftUI

extension View {
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationStack {
            self
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationDestination(isPresented: binding) {
                    view
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                }
        }
    }
}
