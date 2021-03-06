//
//  File.swift
//  wonda
//
//  Created by mp on 13/12/2021.
//

import SwiftUI
import UIKit

struct ImagePickerOLD: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary;

    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerOLD>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()

        if (!UIImagePickerController.isSourceTypeAvailable(sourceType)) {
            fatalError("Cannot find the source type of: \(sourceType)")
        }
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerOLD>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePickerOLD

        init(_ parent: ImagePickerOLD) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
