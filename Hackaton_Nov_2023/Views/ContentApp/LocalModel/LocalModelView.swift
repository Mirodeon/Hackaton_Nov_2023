//
//  LocalModelView.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 08/11/2023.
//

import SwiftUI

struct LocalModelView: View {
    
    var body: some View {
        CustomNavView(tint: .white, background: .black, colorScheme: .dark){
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 0) {
                    
                    ForEach(LocalCaptureFolderDataModel.filesUrls) { urls in
                        
                        NavigationLink(
                            destination: DetailLocalModelView(urls: urls)
                        ) {
                            HStack(spacing: 12) {
                                AsyncImage(
                                    url: urls.preview,
                                    content: { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: 112, maxHeight: 112)
                                    },
                                    placeholder: {
                                        ProgressView()
                                    }
                                )
                                Text("\(urls.directory.lastPathComponent)")
                            }
                            .padding([.horizontal], 24)
                            .padding([.vertical], 12)
                        }
                        
                    }
                    
                }
            }
            .navigationTitle("Local Models")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LocalModelView()
}
