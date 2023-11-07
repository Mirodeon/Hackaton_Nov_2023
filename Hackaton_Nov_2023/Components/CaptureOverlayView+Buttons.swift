//
//  CaptureOverlayView+Buttons.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 07/11/2023.
//

import SwiftUI
import RealityKit
import UniformTypeIdentifiers
import os

extension CaptureOverlayView {

    @MainActor
    struct CaptureButton: View {
        var session: ObjectCaptureSession
        @Binding var hasDetectionFailed: Bool

        var body: some View {
            Button(
                action: {
                    performAction()
                },
                label: {
                    Text(buttonlabel)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 20)
                        .background(.blue)
                        .clipShape(Capsule())
                })
        }

        private var buttonlabel: String {
            if case .ready = session.state {
                return "Continue"
            } else {
                return "Start Capture"
            }
        }

        private func performAction() {
            if case .ready = session.state {
                hasDetectionFailed = !(session.startDetecting())
            } else if case .detecting = session.state {
                session.startCapturing()
            }
        }
    }

    struct ResetBoundingBoxButton: View {
        var session: ObjectCaptureSession

        var body: some View {
            Button(
                action: { session.resetDetection() },
                label: {
                    VStack(spacing: 6) {
                        Image("ResetBbox")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)

                        Text("Reset Box")
                            .font(.footnote)
                            .opacity(0.7)
                    }
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                })
        }
    }

    struct NextButton: View {

        var body: some View {
            Button(action: {
                //go to preview
            },
                   label: {
                Text("Next")
                    .modifier(VisualEffectRoundedCorner())
            })
        }
    }

    struct ManualShotButton: View {
        var session: ObjectCaptureSession

        var body: some View {
            Button(
                action: {
                    session.requestImageCapture()
                },
                label: {
                    if session.canRequestImageCapture {
                        Text(Image(systemName: "button.programmable"))
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    } else {
                        Text(Image(systemName: "button.programmable"))
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    }
                }
            )
            .disabled(!session.canRequestImageCapture)
        }
    }

    struct DocumentBrowser: UIViewControllerRepresentable {
        let startingDir: URL?

        func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentBrowser>) -> UIDocumentPickerViewController {
            let controller = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.item])
            controller.directoryURL = startingDir
            return controller
        }

        func updateUIViewController(
            _ uiViewController: UIDocumentPickerViewController,
            context: UIViewControllerRepresentableContext<DocumentBrowser>) {}
    }

    struct FilesButton: View {
        @EnvironmentObject var captureModel: CaptureDataModel
        @State private var showDocumentBrowser = false

        var body: some View {
            Button(
                action: {
                    showDocumentBrowser = true
                },
                label: {
                    Image(systemName: "folder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22)
                        .foregroundColor(.white)
                })
            .padding(.bottom, 20)
            .padding(.horizontal, 10)
            .sheet(isPresented: $showDocumentBrowser,
                   onDismiss: { showDocumentBrowser = false },
                   content: { DocumentBrowser(startingDir: captureModel.scanFolderManager?.rootScanFolder) })
        }
    }

    struct CancelButton: View {
        @EnvironmentObject var captureModel: CaptureDataModel

        var body: some View {
            Button(action: {
                captureModel.session.cancel()
                captureModel.startNewCapture()
            }, label: {
                Text("Cancel")
                    .modifier(VisualEffectRoundedCorner())
            })
        }
    }
    
    struct NumOfImagesButton: View {
        var session: ObjectCaptureSession
        
        var body: some View {
            VStack(spacing: 8) {
                Text(Image(systemName: "photo"))
                
                Text("\(session.numberOfShotsTaken)/\(session.maximumNumberOfInputImages)")
                    .font(.footnote)
                    .fontWidth(.condensed)
                    .fontDesign(.rounded)
                    .bold()
            }
            .foregroundColor(session.feedback.contains(.overCapturing) ? .red : .white)
        }
    }
}
