//
//  FormViewModel.swift
//  My Images CD
//
//  Created by Marcin Jędrzejak on 17/02/2023.
//

import UIKit

class FormViewModel: ObservableObject {
    @Published var name = ""
    @Published var uiImage: UIImage
    
    var id: String?
    
    var updating: Bool { id != nil }
    
    init(_ uiImage: UIImage) {
        self.uiImage = uiImage
    }
    
    init(_ myImage: MyImage) {
        name = myImage.nameView
        id = myImage.imageID
        uiImage = UIImage(systemName: "photo")!
    }
    
    var incomplete: Bool {
        name.isEmpty || uiImage == UIImage(systemName: "photo")!
    }
}
