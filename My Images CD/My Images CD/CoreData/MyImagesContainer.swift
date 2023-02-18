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
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
    
    
}
