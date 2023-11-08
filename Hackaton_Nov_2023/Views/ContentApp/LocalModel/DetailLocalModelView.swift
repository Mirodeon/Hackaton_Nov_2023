//
//  DetailLocalModelView.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 08/11/2023.
//

import SwiftUI

struct DetailLocalModelView: View {
    @EnvironmentObject var networkCaptureModel: NetworkCaptureDataModel
    @EnvironmentObject var authModel: AuthDataModel
    let urls: FileScanUrls
    @State var showReconstruct = false
    @State var showBtnCloud = false
    
    var body: some View {
        VStack(spacing: 24){
            AsyncImage(
                url: urls.preview,
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 356)
                },
                placeholder: {
                    ProgressView()
                }
            )
            
            Spacer()
            
            Group{
                Button(
                    action: {
                        showReconstruct = true
                    }
                ){
                    Label("Reconstruct", systemImage: "person")
                        .bold()
                }
                if (showBtnCloud){
                    Button(
                        action: {
                            networkCaptureModel.addModelToStorage(urls: urls, emailUser: authModel.user?.email ?? "") {
                                showBtnCloud = false
                            }
                        }
                    ){
                        Label("Save in Cloud", systemImage: "person")
                            .bold()
                    }
                }
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding([.horizontal], 18)
            .padding([.vertical], 10)
            .background(.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.white, lineWidth: 2)
            )
            .padding([.horizontal], 48)
            
            Spacer()
        }
        .navigationTitle("Model: \(urls.directory.lastPathComponent)")
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showReconstruct){
            ModelView(modelFile: urls.model.appendingPathComponent("model-mobile.usdz")) { showReconstruct = false }
        }
        .onAppear{
            networkCaptureModel.checkIfExist(urls: urls, emailUser: authModel.user?.email ?? "") { result in
                showBtnCloud = result
            }
        }
    }
}

#Preview {
    DetailLocalModelView(urls:FileScanUrls(directory: URL(string:"")!, model: URL(string:"")!, preview: URL(string:"")!))
}
