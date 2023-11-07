//
//  ContentView.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 07/11/2023.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    @StateObject var captureModel: CaptureDataModel = CaptureDataModel.instance

    var body: some View {
        CustomTabView(selected: .white, unselected: .systemGray2, background: .black, colorScheme: .dark) {
            CaptureView()
                .tabItem {
                    Label("Capture", systemImage: "popcorn")
                }
            
            Text("")
                .tabItem {
                    Label("Represent", systemImage: "person")
                }
        }
        .environmentObject(captureModel)
    }
}

#Preview {
    ContentView()
}
