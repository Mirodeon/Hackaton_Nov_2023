//
//  ReconstructProgressView.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 08/11/2023.
//

import Foundation
import RealityKit
import SwiftUI
import os

struct ReconstructProgressView: View {
    @EnvironmentObject var captureModel: CaptureDataModel
    let outputFile: URL
    @Binding var completed: Bool
    @Binding var cancelled: Bool
    
    @State private var progress: Float = 0
    @State private var estimatedRemainingTime: TimeInterval?
    @State private var processingStageDescription: String?
    @State private var pointCloud: PhotogrammetrySession.PointCloud?
    @State private var gotError: Bool = false
    @State private var error: Error?
    @State private var isCancelling: Bool = false
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    private var padding: CGFloat {
        horizontalSizeClass == .regular ? 60.0 : 24.0
    }
    private func isReconstructing() -> Bool {
        return !completed && !gotError && !cancelled
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if isReconstructing() {
                HStack {
                    Button(action: {
                        isCancelling = true
                        captureModel.photogrammetrySession?.cancel()
                    }, label: {
                        Text("Cancel")
                            .font(.headline)
                            .bold()
                            .padding(30)
                            .foregroundColor(.blue)
                    })
                    .padding(.trailing)
                    
                    Spacer()
                }
            }
            
            Spacer()
            
            ProgressBarView(
                progress: progress,
                estimatedRemainingTime: estimatedRemainingTime,
                processingStageDescription: processingStageDescription
            )
            .padding(padding)
            
            Spacer()
            Spacer()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 20)
        .task {
            assert(captureModel.photogrammetrySession != nil)
            let session = captureModel.photogrammetrySession!
            
            let outputs = UntilProcessingCompleteFilter(input: session.outputs)
            do {
                try session.process(requests: [.modelFile(url: outputFile)])
            } catch {
                
            }
            for await output in outputs {
                switch output {
                case .inputComplete:
                    break
                case .requestProgress(let request, fractionComplete: let fractionComplete):
                    if case .modelFile = request {
                        progress = Float(fractionComplete)
                    }
                case .requestProgressInfo(let request, let progressInfo):
                    if case .modelFile = request {
                        estimatedRemainingTime = progressInfo.estimatedRemainingTime
                        processingStageDescription = progressInfo.processingStage?.processingStageString
                    }
                case .requestComplete(let request, _):
                    switch request {
                    case .modelFile(_, _, _): print("request complete.")
                    case .modelEntity(_, _), .bounds, .poses, .pointCloud:
                        // Not supported yet
                        break
                    @unknown default:
                        print("unknown error.")
                    }
                case .requestError(_, let requestError):
                    if !isCancelling {
                        gotError = true
                        error = requestError
                    }
                case .processingComplete:
                    if !gotError {
                        completed = true
                    }
                case .processingCancelled:
                    cancelled = true
                    captureModel.startNewCapture()
                case .invalidSample(id: _, reason: _), .skippedSample(id: _), .automaticDownsampling:
                    continue
                case .stitchingIncomplete:
                    break
                @unknown default:
                    print("unknown error.")
                }
            }
            print(">>>>>>>>>> RECONSTRUCTION TASK EXIT >>>>>>>>>>>>>>>>>")
        }
    }
}

#Preview {
    ReconstructProgressView(outputFile: URL(string: "")!, completed: .constant(false), cancelled: .constant(false))
        .environmentObject(CaptureDataModel.instance)
}
