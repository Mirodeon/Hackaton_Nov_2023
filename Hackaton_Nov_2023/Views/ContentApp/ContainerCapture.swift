//
//  ContainerCapture.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 07/11/2023.
//

import SwiftUI

struct ContainerCapture: View {
    
    var body: some View {
        CustomTabView(selected: .white, unselected: .systemGray2, background: .black, colorScheme: .dark) {
            CaptureView()
                .tabItem {
                    Label("Capture", systemImage: "popcorn")
                }
            
            LocalModelView()
                .tabItem {
                    Label("Local", systemImage: "person")
                }
        }
    }
}

#Preview {
    ContainerCapture()
}
