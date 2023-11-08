//
//  CustomNavView.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 07/11/2023.
//

import SwiftUI

struct CustomNavView<Content: View>: View {
    let tint: UIColor
    let background: UIColor
    let colorScheme: ColorScheme
    @ViewBuilder let viewBuilder: () -> Content
    
    var body: some View {
        NavigationView {
            viewBuilder()
        }
        .onAppear() {
            setupNavBarAppearance()
        }
        .accentColor(Color(tint))
        .preferredColorScheme(colorScheme)
    }
    
    private func setupNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = background
                    
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = tint
    }
}

struct CustomNavView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView(tint: .white, background: .black, colorScheme: .dark) {
            Text("Example")
                .navigationTitle("Example")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}
