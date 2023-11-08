//
//  NetworkCaptureDataModel.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 08/11/2023.
//

import SwiftUI
import Firebase
import FirebaseStorage

class NetworkCaptureDataModel: ObservableObject, Identifiable {
    let storage = Storage.storage()
    let storageRef: StorageReference
    let db = Firestore.firestore()
    let collectionRef: CollectionReference
    
    init() {
        storageRef = storage.reference()
        collectionRef = db.collection("models")
    }
    static let instance = NetworkCaptureDataModel()
    
    private func addDocumentToFirestore(urlStorage: String, emailUser: String, nameFile: String, action: @escaping () -> ()) {
        collectionRef.addDocument(data: ["urlStorage": urlStorage, "emailUser": emailUser, "nameFile": nameFile]) { error in
            if let error = error {
                print("Erreur lors de l'ajout de l'URL au Firestore : \(error.localizedDescription)")
            } else {
                print("URL ajoutée avec succès au Firestore")
                action()
            }
        }
    }
    
    func addModelToStorage(urls: FileScanUrls, emailUser: String, action: @escaping () -> ()) {
        let localModel = urls.model.appendingPathComponent("model-mobile.usdz")
        let nameFile = urls.directory.lastPathComponent
        
        let modelRef = storageRef.child("\(emailUser)/\(nameFile)/model-mobile.usdz")
        print("let's go upload!")
        let uploadTask = modelRef.putFile(from: localModel, metadata: nil) { metadata, error in
            print("Try upload")
            if let error = error {
                print(error)
                return
            }
            
            guard let metadata = metadata else {
                print("Metadata problem.")
                return
            }
            modelRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return
                }
                print("Try put in db now !")
                self.addDocumentToFirestore(urlStorage: downloadURL.absoluteString, emailUser: emailUser, nameFile: nameFile) {
                    action()
                }
            }
        }
        uploadTask.enqueue()
    }
    
    func checkIfExist (urls: FileScanUrls, emailUser: String, action: @escaping (Bool) -> ()) {
        let nameFile = urls.directory.lastPathComponent
        
        let modelRef = storageRef.child("\(emailUser)/\(nameFile)/")
        
        modelRef.listAll { result, error in
            if let error = error {
                print("Unable to retrieve in storage.")
                action(true)
            } else {
                if let result = result {
                    action(result.items.count == 0)
                    print("pouet pouet")
                } else {
                    action(false)
                    print("pouet")
                }
            }
        }
    }
}
