//
//  MyImage+Extension.swift
//  My Images CD
//
//  Created by Marcin Jędrzejak on 17/02/2023.
//

import Foundation

extension MyImage {
    var nameView: String {
        name ?? ""
    }
    
    var imageID: String {
        id ?? ""
    }
}
