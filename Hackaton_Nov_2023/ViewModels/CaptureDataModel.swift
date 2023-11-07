//
//  CaptureDataModel.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 07/11/2023.
//

import Foundation
import Combine
import RealityKit
import SwiftUI
import os

@MainActor
class CaptureDataModel: ObservableObject, Identifiable {
    
    static let instance = CaptureDataModel()
    @Published var session: ObjectCaptureSession
    static let minNumImages = 10
    var scanFolderManager: CaptureFolderManager?
    
    init() {
        session = ObjectCaptureSession()
        
        if let folderManager = CaptureFolderManager() {
            scanFolderManager = folderManager
            var configuration = ObjectCaptureSession.Configuration()
            configuration.checkpointDirectory = folderManager.snapshotsFolder
            configuration.isOverCaptureEnabled = false
            
            session.start(
                imagesDirectory: folderManager.imagesFolder,
                configuration: configuration
            )
        }
    }
}
