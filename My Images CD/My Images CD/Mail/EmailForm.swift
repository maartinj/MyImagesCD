//
//  EmailForm.swift
//  My Images CD
//
//  Created by Marcin Jędrzejak on 20/02/2023.
//

import Foundation

struct EmailForm {
    var toAddress = ""
    var subject = ""
    var messageHeader = ""
    var data: Data?
    var fileName = ""
    var mimeType = "text/plain"
    var body: String {
        messageHeader.isEmpty ? "" : messageHeader + "\n"
    }
}
