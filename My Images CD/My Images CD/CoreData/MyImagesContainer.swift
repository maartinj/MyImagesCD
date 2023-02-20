//
//  MyImagesContainer.swift
//  My Images CD
//
//  Created by Marcin Jędrzejak on 17/02/2023.
//

import Foundation
import CoreData

class MyImagesContainer {
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "MyImagesDataModel")
        guard let path = persistentContainer
            .persistentStoreDescriptions
            .first?
            .url?
            .path() else {
            fatalError("Could not find persistent container")
        }
        print("Core Data", path)
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
}
