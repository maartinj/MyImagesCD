//
//  MyImage+Extension.swift
//  My Images CD
//
//  Created by Marcin Jędrzejak on 17/02/2023.
//

import UIKit

extension MyImage {
    var nameView: String {
        name ?? ""
    }
    
    var imageID: String {
        id ?? ""
    }
    
    var uiImage: UIImage {
        if !imageID.isEmpty,
           let image = FileManager().retrieveImage(with: imageID) {
            return image
        } else {
            return UIImage(systemName: "photo")!
        }
    }
}
