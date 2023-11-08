//
//  ProgressBarView.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 08/11/2023.
//

import Foundation
import SwiftUI
import RealityKit

struct ProgressBarView: View {
    @EnvironmentObject var captureModel: CaptureDataModel

    var progress: Float
    var estimatedRemainingTime: TimeInterval?
    var processingStageDescription: String?

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private var formattedEstimatedRemainingTime: String? {
        guard let estimatedRemainingTime = estimatedRemainingTime else { return nil }

        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        return formatter.string(from: estimatedRemainingTime)
    }

    private var numOfImages: Int {
        guard let folderManager = captureModel.scanFolderManager else { return 0 }
        guard let urls = try? FileManager.default.contentsOfDirectory(
            at: folderManager.imagesFolder,
            includingPropertiesForKeys: nil
        ) else {
            return 0
        }
        return urls.filter { $0.pathExtension.uppercased() == "HEIC" }.count
    }

    var body: some View {
        VStack(spacing: 22) {
            VStack(spacing: 12) {
                HStack(spacing: 0) {
                    Text(processingStageDescription ?? LocalizedString.processing)

                    Spacer()

                    Text(progress, format: .percent.precision(.fractionLength(0)))
                        .bold()
                        .monospacedDigit()
                }
                .font(.body)

                ProgressView(value: progress)
            }

            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .center) {
                    Image(systemName: "photo")

                    Text(String(numOfImages))
                        .frame(alignment: .bottom)
                        .hidden()
                        .overlay {
                            Text(String(numOfImages))
                                .font(.caption)
                                .bold()
                        }
                }
                .font(.subheadline)
                .padding(.trailing, 16)

                VStack(alignment: .leading) {
                    Text(LocalizedString.processingModelDescription)

                    Text("\(LocalizedString.estimatedRemainingTime) \(formattedEstimatedRemainingTime ?? LocalizedString.calculating)")
                }
                .font(.subheadline)
            }
            .foregroundColor(.secondary)
        }
    }

    private struct LocalizedString {
        static let processing = "Processing"

        static let processingModelDescription = "Keep app running while processing."

        static let estimatedRemainingTime = "Estimated time remaining: "

        static let calculating = "Calculating…"
    }
}

#Preview {
    ProgressBarView(progress: 0)
        .environmentObject(CaptureDataModel.instance)
}
