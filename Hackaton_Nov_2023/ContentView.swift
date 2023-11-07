//
//  ContentView.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 07/11/2023.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    @State var isPresented = false
    
    var body: some View {
            Form {
                Section(header: Text("Login")) {
                    HStack {
                        Text("Username")
                        TextField("Username", text: $username)
                            .multilineTextAlignment(.trailing)
                            .tint(.white)
                    }
                    
                    HStack {
                        Text("Password")
                        TextField("Password", text: $password)
                            .multilineTextAlignment(.trailing)
                            .tint(.white)
                    }
                }
                
                
                Button(action: {
                    isPresented = true
                }){
                    Label("Connect", systemImage: "plus")
                        .bold()
                        .foregroundColor(.white)
                }
                
                
            }.navigate(to: ContainerCapture(), when: $isPresented)
    }
}

#Preview {
    ContentView()
}
