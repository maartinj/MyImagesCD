//
//  FormType.swift
//  My Images CD
//
//  Created by Marcin Jędrzejak on 17/02/2023.
//

import Foundation

enum FormType: Identifiable {
    case new
    case update
    
    var id: String {
        switch self {
        case .new:
            return "new"
        case .update:
            return "update"
        }
    }
}
