//
//  PhotogrammetrySession+Extension.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 08/11/2023.
//
import Foundation
import SwiftUI
import RealityKit

extension PhotogrammetrySession.Output.ProcessingStage {
    var processingStageString: String? {
        switch self {
            case .preProcessing:
                return "Pre-Processing"
            case .imageAlignment:
                return "Aligning Images"
            case .pointCloudGeneration:
                return "Generating Point Cloud"
            case .meshGeneration:
                return "Generating Mesh"
            case .textureMapping:
                return "Mapping Texture"
            case .optimization:
                return "Optimizing"
            default:
                return nil
        }
    }
}
