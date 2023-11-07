//
//  TabBarView.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 07/11/2023.
//

import SwiftUI

struct CustomTabView<Content: View>: View {
    let selected: UIColor
    let unselected: UIColor
    let background: UIColor
    let colorScheme: ColorScheme
    @ViewBuilder let viewBuilder: () -> Content
    
    var body: some View {
        TabView {
            viewBuilder()
        }
        .onAppear() {
            setupTabBarAppearance()
        }
        .preferredColorScheme(colorScheme)
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = background
        
        appearance.stackedLayoutAppearance.selected.iconColor = selected
        appearance.stackedLayoutAppearance.selected.titleTextAttributes =
        [.foregroundColor: selected]
        
        appearance.stackedLayoutAppearance.normal.iconColor = unselected
        appearance.stackedLayoutAppearance.normal.titleTextAttributes =
        [.foregroundColor: unselected]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView(selected: .white, unselected: .systemGray2, background: .black, colorScheme: .dark) {
            Text("Example")
                .tabItem {
                    Label("Example", systemImage: "photo")
                }
        }
    }
}
