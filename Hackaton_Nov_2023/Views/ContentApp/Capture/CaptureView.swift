//
//  CaptureView.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 07/11/2023.
//

import SwiftUI
import RealityKit

struct CaptureView: View {
    @EnvironmentObject var captureModel: CaptureDataModel
    @State var showReconstruct = false
    
    var body: some View {
        if captureModel.session.userCompletedScanPass {
            VStack {
                ObjectCapturePointCloudView(session: captureModel.session)
                Button(
                    action: {
                        captureModel.session.finish()
                        captureModel.startReconstruction()
                        showReconstruct = true
                    },
                    label: {
                        Text("Finish")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 20)
                            .background(.blue)
                            .clipShape(Capsule())
                    })
            }
            .sheet(isPresented: $showReconstruct) {
                if let folderManager = captureModel.scanFolderManager {
                    ReconstructView(outputFile: folderManager.modelsFolder.appendingPathComponent("model-mobile.usdz"))
                }
            }
        } else {
            ZStack {
                ObjectCaptureView(session: captureModel.session)
                if shouldShowOverlayView {
                    CaptureOverlayView()
                }
            }
        }
    }
    
    private var shouldShowOverlayView: Bool {
        !captureModel.session.isPaused && captureModel.session.cameraTracking == .normal
    }
}

#Preview {
    CaptureView()
        .environmentObject(CaptureDataModel.instance)
}
