//
//  ContentView.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 07/11/2023.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var isPresented = false
    
    var body: some View {
            LoginView()
    }
}

#Preview {
    ContentView()
}
