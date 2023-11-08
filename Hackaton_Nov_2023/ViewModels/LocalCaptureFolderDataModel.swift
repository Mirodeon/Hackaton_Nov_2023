//
//  LocalCaptureFolderDataModel.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 08/11/2023.
//

import Foundation

class LocalCaptureFolderDataModel {
    
    static var filesUrls: [FileScanUrls] {
        getFilesUrls()
    }

    private static func rootScansFolder() -> [URL] {
        guard let documentsFolder =
                try? FileManager.default.url(
                    for: .documentDirectory,
                    in: .userDomainMask,
                    appropriateFor: nil, create: false
                )
        else {
            return []
        }
        
        let rootFolder = documentsFolder.appendingPathComponent("Scans/", isDirectory: true)
        return try! FileManager.default.contentsOfDirectory(at: rootFolder, includingPropertiesForKeys: nil)
    }
    
    private static func imagesPreview(urlScan: URL) -> URL {
        let url = urlScan.appendingPathComponent("Images/")
        let images = try! FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        return images[0]
    }
    
    private static func removeIfEmpty(urlToCheck: URL, urlToRemove: URL) -> Bool {
        let content = try! FileManager.default.contentsOfDirectory(at: urlToCheck, includingPropertiesForKeys: nil)
        if content.count < 1 {
            do {
                try FileManager.default.removeItem(at: urlToRemove)
            } catch {
                print("Failed to remove empty scan directory.")
            }
            return true
        }
        return false
    }
    
    private static func getFilesUrls() -> [FileScanUrls] {
        var FilesUrls: [FileScanUrls] = []
        for url in rootScansFolder() {
            let modelDirectory = url.appendingPathComponent("Models/")
            let hasRemove = removeIfEmpty(urlToCheck: modelDirectory, urlToRemove: url)
            
            if (!hasRemove) {
                FilesUrls.append(
                    FileScanUrls(
                        directory: url,
                        model: modelDirectory,
                        preview: imagesPreview(urlScan: url)
                    )
                )
            }
        }
        return FilesUrls
    }
    
    
     
}

struct FileScanUrls: Identifiable {
    let id = UUID()
    let directory: URL
    let model: URL
    let preview: URL
}
