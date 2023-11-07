//
//  CaptureOverlayView.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 07/11/2023.
//

import SwiftUI

struct CaptureOverlayView: View {
    @EnvironmentObject var captureModel: CaptureDataModel
    @State private var hasDetectionFailed = false
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var deviceOrientation: UIDeviceOrientation = UIDevice.current.orientation
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                CancelButton()
                    .disabled(shouldDisableCancelButton ? true : false)
                Spacer()
                NextButton()
                    .opacity(shouldShowNextButton ? 1 : 0)
                    .disabled(!shouldShowNextButton)
            }
            .foregroundColor(.white)

            Spacer()

            if !capturingStarted {
                BoundingBoxGuidanceView(session: captureModel.session, hasDetectionFailed: hasDetectionFailed)
            }
            
            HStack(alignment: .bottom, spacing: 0) {
                HStack(spacing: 0) {
                    if case .capturing = captureModel.session.state {
                        NumOfImagesButton(session: captureModel.session)
                            .rotationEffect(rotationAngle)
                            .transition(.opacity)
                    } else if case .detecting = captureModel.session.state {
                        ResetBoundingBoxButton(session: captureModel.session)
                            .transition(.opacity)
                    } else if case .ready = captureModel.session.state {
                        FilesButton()
                            .transition(.opacity)
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                if !capturingStarted {
                    CaptureButton(session: captureModel.session, hasDetectionFailed: $hasDetectionFailed)
                        .layoutPriority(1)
                }
                
                HStack {
                    Spacer()
                    if case .capturing = captureModel.session.state {
                        ManualShotButton(session: captureModel.session)
                            .transition(.opacity)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .padding(.horizontal, 15)
        .background(.clear)
        .allowsHitTesting(true)
        .animation(.default, value: false)
        .task {
            for await _ in NotificationCenter.default.notifications(named:
                    UIDevice.orientationDidChangeNotification).map({ $0.name }) {
                withAnimation {
                    deviceOrientation = UIDevice.current.orientation
                }
            }
        }
    }
    
    private var capturingStarted: Bool {
        switch captureModel.session.state {
        case .initializing, .ready, .detecting:
            return false
        default:
            return true
        }
    }
    
    private var shouldShowNextButton: Bool {
        capturingStarted
    }
    
    private var shouldDisableCancelButton: Bool {
        captureModel.session.state == .ready || captureModel.session.state == .initializing
    }
    
    private var rotationAngle: Angle {
        switch deviceOrientation {
        case .landscapeLeft:
            return Angle(degrees: 90)
        case .landscapeRight:
            return Angle(degrees: -90)
        case .portraitUpsideDown:
            return Angle(degrees: 180)
        default:
            return Angle(degrees: 0)
        }
    }
}

#Preview {
    CaptureOverlayView()
        .environmentObject(CaptureDataModel.instance)
}
