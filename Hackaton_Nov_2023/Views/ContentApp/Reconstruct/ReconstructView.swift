//
//  ReconstructView.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 08/11/2023.
//

import SwiftUI

struct ReconstructView: View {
    @EnvironmentObject var captureModel: CaptureDataModel
    let outputFile: URL

    @State private var completed: Bool = false
    @State private var cancelled: Bool = false

    var body: some View {
        if completed && !cancelled {
            ModelView(modelFile: outputFile, endCaptureCallback: { [weak captureModel] in
                captureModel?.startNewCapture()
            })
        } else {
            ReconstructProgressView(outputFile: outputFile, completed: $completed, cancelled: $cancelled)
            .interactiveDismissDisabled()
        }
    }
}

#Preview {
    ReconstructView(outputFile: URL(string: "")!)
        .environmentObject(CaptureDataModel.instance)
}
