//
//  ShareService.swift
//  My Images CD
//
//  Created by Marcin Jędrzejak on 20/02/2023.
//

import Foundation
import ZIPFoundation

struct CodableImage: Codable, Equatable {
    let comment: String
    let dateTaken: Date
    let id: String
    let name: String
    let receivedFrom: String
}

class ShareService: ObservableObject {
    @Published var codableImage: CodableImage?
    static let ext = "myimg"
    func saveMyImage(_ codableImage: CodableImage) {
        let filename = "\(codableImage.id).json"
        do {
            let data = try JSONEncoder().encode(codableImage)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveJSON(jsonString, filename: filename)
            zipFiles(id: codableImage.id)
        } catch {
            print("Could not encode data")
        }
    }
    
    func restore(url: URL) {
        let filename = url.lastPathComponent
        let jsonName = filename.replacingOccurrences(of: ShareService.ext, with: "json")
        let zipName = filename.replacingOccurrences(of: ShareService.ext, with: "zip")
        let imgName = filename.replacingOccurrences(of: ShareService.ext, with: "jpg")
        let imgURL = URL.documentsDirectory.appending(path: imgName)
        let zipURL = URL.documentsDirectory.appending(path: zipName)
        let unzippedJSONURL = URL.documentsDirectory.appending(path: jsonName)
        if url.pathExtension == Self.ext {
            try? FileManager().moveItem(at: url, to: zipURL)
            try? FileManager().removeItem(at: imgURL)
            do {
                try FileManager().unzipItem(at: zipURL, to: URL.documentsDirectory)
            } catch {
                print(error.localizedDescription)
            }
            if let codableImage = FileManager().decodeJSON(with: URL.documentsDirectory.appending(path: jsonName)) {
                self.codableImage = codableImage
            }
        }
        try? FileManager().removeItem(at: zipURL)
        try? FileManager().removeItem(at: unzippedJSONURL)
    }
    
    func zipFiles(id: String) {
        let archiveURL = URL.documentsDirectory.appending(path: "\(id).\(Self.ext)")
        guard let archive = Archive(url: archiveURL, accessMode: .create) else {
            return
        }
        let imageURL = URL.documentsDirectory.appending(path: "\(id).jpg")
        let jsonURL = URL.documentsDirectory.appending(path: "\(id).json")
        do {
            try archive.addEntry(with: imageURL.lastPathComponent, relativeTo: URL.documentsDirectory)
            try archive.addEntry(with: jsonURL.lastPathComponent, relativeTo: URL.documentsDirectory)
            try FileManager().removeItem(at: jsonURL)
        } catch {
            print(error.localizedDescription)
        }
    }
}
