//
//  ContentView.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 07/11/2023.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    @StateObject var authModel: AuthDataModel = AuthDataModel.instance
    @StateObject var captureModel: CaptureDataModel = CaptureDataModel.instance
    @StateObject var networkCaptureModel: NetworkCaptureDataModel = NetworkCaptureDataModel.instance
    
    var body: some View {
            LoginView()
            .environmentObject(authModel)
            .environmentObject(captureModel)
            .environmentObject(networkCaptureModel)
    }
}

#Preview {
    ContentView()
}
