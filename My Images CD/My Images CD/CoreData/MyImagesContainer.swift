//
//  MyImagesContainer.swift
//  My Images CD
//
//  Created by Marcin Jędrzejak on 17/02/2023.
//

import Foundation
import CoreData

// Brakuje CloudKit, do dodania po zakupie full Apple Dev account

class MyImagesContainer {
    let persistentCloudKitContainer: NSPersistentCloudKitContainer
    
    init() {
        UIImageTransformer.register()
        persistentCloudKitContainer = NSPersistentCloudKitContainer(name: "MyImagesDataModel")
        guard let path = persistentCloudKitContainer
            .persistentStoreDescriptions
            .first?
            .url?
            .path() else {
            fatalError("Could not find persistent container")
        }
        print("Core Data", path)
        guard let description = persistentCloudKitContainer.persistentStoreDescriptions.first else {
            fatalError("Failed to initialize persistent container")
        }
        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        persistentCloudKitContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        persistentCloudKitContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentCloudKitContainer.loadPersistentStores { _, error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
}
