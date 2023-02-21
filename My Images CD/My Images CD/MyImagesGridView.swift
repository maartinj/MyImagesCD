//
// Created for My Images CD
// by Stewart Lynch on 2022-10-31
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI
import PhotosUI

// Playlista: https://www.youtube.com/watch?v=og1R6HIYU5c&list=PLBn01m5Vbs4DYmnxdD1ZuEJA7yXqHcSEd&ab_channel=StewartLynch

struct MyImagesGridView: View {
    @EnvironmentObject var shareService: ShareService
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)])
    private var myImages: FetchedResults<MyImage>
    @StateObject private var imagePicker = ImagePicker()
    @State private var formType: FormType?
    @State private var imageExists = false
    let columns = [GridItem(.adaptive(minimum: 100))]
    var body: some View {
        NavigationStack {
            Group {
                if !myImages.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(myImages) { myImage in
                                Button {
                                    formType = .update(myImage)
                                } label: {
                                    VStack {
                                        Image(uiImage: myImage.uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .clipped()
                                            .shadow(radius: 5.0)
                                        Text(myImage.nameView)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                } else {
                    Text("Select your first image")
                }
            }
            .navigationTitle("My Images")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    PhotosPicker("New Image",
                                 selection: $imagePicker.imageSelection,
                                 matching: .images,
                                 photoLibrary: .shared())
                    .buttonStyle(.borderedProminent)
                }
            }
            .onChange(of: imagePicker.uiImage) { newImage in
                if let newImage {
                    formType = .new(newImage)
                }
            }
            .onChange(of: shareService.codableImage) { codableImage in
                if let codableImage {
                    if let myImage = myImages.first(where: { $0.id == codableImage.id }) {
                        // This is an update of an existing image
                        updateImageInfo(myImage: myImage)
                        imageExists.toggle()
                    } else {
                        // This is a new MyImage Item
                        restoreMyImage()
                    }
                }
            }
            .sheet(item: $formType) { $0 }
            .alert("Image Updated", isPresented: $imageExists) {
                Button("OK") {}
            }
        }
    }
    
    func restoreMyImage() {
        if let codableImage = shareService.codableImage {
            let imgURL = URL.documentsDirectory.appending(path: "\(codableImage.id).jpg")
            let newImage = MyImage(context: moc)
            if let data = try? Data(contentsOf: imgURL), let uiImage = UIImage(data: data) {
                newImage.image = uiImage
            }
            newImage.name = codableImage.name
            newImage.id = codableImage.id
            newImage.comment = codableImage.comment
            newImage.dateTaken = codableImage.dateTaken
            newImage.receivedFrom = codableImage.receivedFrom
            try? moc.save()
            try? FileManager().removeItem(at: imgURL)
        }
        shareService.codableImage = nil
    }
    
    func updateImageInfo(myImage: MyImage) {
        if let codableImage = shareService.codableImage {
            let imgURL = URL.documentsDirectory.appending(path: "\(codableImage.id).jpg")
            if let data = try? Data(contentsOf: imgURL), let uiImage = UIImage(data: data) {
                myImage.image = uiImage
            }
            myImage.name = codableImage.name
            myImage.id = codableImage.id
            myImage.comment = codableImage.comment
            myImage.dateTaken = codableImage.dateTaken
            myImage.receivedFrom = codableImage.receivedFrom
            try? moc.save()
            try? FileManager().removeItem(at: imgURL)
        }
        shareService.codableImage = nil
    }
}

struct MyImagesGridView_Previews: PreviewProvider {
    static var previews: some View {
        MyImagesGridView()
            .environmentObject(ShareService())
    }
}
