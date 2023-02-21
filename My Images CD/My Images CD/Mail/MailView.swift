//
//  MailView.swift
//  My Images CD
//
//  Created by Marcin Jędrzejak on 20/02/2023.
//

import SwiftUI
import UIKit
import MessageUI

// Credit for this struct goes to https://swiftuirecipes.com/blog/send-mail-in-swiftui

typealias MailViewCallback = ((Result<MFMailComposeResult, Error>) -> Void)?

struct MailView: UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    @Binding var mailForm: EmailForm
    let callback: MailViewCallback
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var dismiss: DismissAction
        @Binding var data: EmailForm
        let callback: MailViewCallback
        
        init(dismiss: DismissAction,
             data: Binding<EmailForm>,
             callback: MailViewCallback) {
            self.dismiss = dismiss
            _data = data
            self.callback = callback
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            if let error = error {
                callback?(.failure(error))
            } else {
                callback?(.success(result))
            }
            dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(dismiss: dismiss, data: $mailForm, callback: callback)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let mvc = MFMailComposeViewController()
        mvc.mailComposeDelegate = context.coordinator
        mvc.setSubject(mailForm.subject)
        mvc.setToRecipients([mailForm.toAddress])
        mvc.setMessageBody(mailForm.body, isHTML: false)
        mvc.addAttachmentData(mailForm.data!, mimeType: mailForm.mimeType, fileName: "\(mailForm.fileName)")
        mvc.accessibilityElementDidLoseFocus()
        return mvc
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailView>) {
    }
    
    static var canSendMail: Bool {
        MFMailComposeViewController.canSendMail()
    }
}
