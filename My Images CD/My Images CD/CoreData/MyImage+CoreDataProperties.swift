//
//  MyImage+CoreDataProperties.swift
//  My Images CD
//
//  Created by Marcin Jędrzejak on 21/02/2023.
//
//

import Foundation
import CoreData
import UIKit


extension MyImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyImage> {
        return NSFetchRequest<MyImage>(entityName: "MyImage")
    }

    @NSManaged public var comment: String?
    @NSManaged public var dateTaken: Date?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var receivedFrom: String?
    @NSManaged public var image: UIImage?

}

extension MyImage : Identifiable {

}
