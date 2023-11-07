//
//  BoundingBoxGuidanceView.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 07/11/2023.
//

import SwiftUI
import RealityKit

@MainActor
struct BoundingBoxGuidanceView: View {
    var session: ObjectCaptureSession
    var hasDetectionFailed: Bool
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        HStack {
            if let guidanceText = guidanceText {
                Text(guidanceText)
                    .font(.callout)
                    .bold()
                    .foregroundColor(.white)
                    .transition(.opacity)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: horizontalSizeClass == .regular ? 400 : 360)
            }
        }
    }

    private var guidanceText: String? {
        if case .ready = session.state {
            if hasDetectionFailed {
                return "Can‘t find your object. It should be larger than 3in (8cm) in each dimension."
            } else {
                return "Move close and center the dot on your object, then tap Continue. (Object Capture, State)"
            }
        } else if case .detecting = session.state {
            return "Move around to ensure that the whole object is inside the box. Drag handles to manually resize. (Object Capture, State)"
        } else {
            return nil
        }
    }
}

#Preview {
    BoundingBoxGuidanceView(session: CaptureDataModel.instance.session, hasDetectionFailed: false)
}
