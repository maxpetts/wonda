//
//  ContentView.swift
//  wonda
//
//  Created by mp on 23/11/2021.
//

import SwiftUI

struct TextRecognitionView: View {
    
    @State private var contained_text: String = ""
    @State private var image = UIImage()
    @State private var showPhotoLibrary = false
    
    var body: some View {
        VStack{
            Image(uiImage: self.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(4)
                .addRoundBorder(Color.black, width: 2, cornerRadius: 10)
            Button("swap image", action: { self.showPhotoLibrary = true })
            Spacer()
            Button(action: {
                if (image.size.width == 0 || image.size.height == 0) {
                    contained_text = "Please select an image first"
                } else {
                contained_text = detect_text(self.image)
                }
            }) {
                Text("get text")
                    .frame(minWidth: 250, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
            }
            Text(contained_text)
            Spacer()
            Text("By Max Petts (not a designer)")
                .font(.caption2)
                .foregroundColor(Color.gray)
        }.sheet(isPresented: $showPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }.padding()
    }
}

// Stealy Stealy: https://stackoverflow.com/questions/57753997/rounded-borders-in-swiftui
extension View {
    public func addRoundBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
            .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}