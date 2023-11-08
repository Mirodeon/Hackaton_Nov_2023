//
//  LoginView.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 07/11/2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authModel: AuthDataModel
    @State var email: String = "mehdi@dolly.com"
    @State var password: String = "dolly123"
    @State var isPresented = false
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack(alignment: .center, spacing: 24) {
                Group{
                    HStack {
                        Text("Email:")
                            .bold()
                        TextField("Email", text: $email)
                            .multilineTextAlignment(.trailing)
                            .tint(.white)
                    }
                    
                    HStack {
                        Text("Password:")
                            .bold()
                        TextField("Password", text: $password)
                            .multilineTextAlignment(.trailing)
                            .tint(.white)
                    }
                }
                .foregroundColor(.white)
                .padding([.horizontal], 18)
                .padding([.vertical], 10)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.white, lineWidth: 2)
                )
                .padding([.horizontal], 48)
                
                Button(
                    action: {
                        authModel.signin(email: email, password: password) { connect in
                            isPresented = connect
                        }
                        //isPresented = true
                    }
                ){
                    Label("Connect", systemImage: "person")
                        .bold()
                }
                .foregroundColor(.black)
                .padding([.horizontal], 18)
                .padding([.vertical], 10)
                .background(.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.white, lineWidth: 2)
                )
                .padding([.horizontal], 48)
            }
        }
        .background(.black)
        .fullScreenCover(isPresented: $isPresented){
            ContainerCapture()
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthDataModel.instance)
}