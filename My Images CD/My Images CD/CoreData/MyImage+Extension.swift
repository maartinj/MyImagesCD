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
        image ?? UIImage(systemName: "photo")!
    }
    
    var commentView: String {
        comment ?? ""
    }
    
    var receivedFromView: String {
        receivedFrom ?? ""
    }
}
