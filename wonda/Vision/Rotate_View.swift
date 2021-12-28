//
//  ContentView.swift
//  wonda
//
//  Created by mp on 23/11/2021.
//

import SwiftUI

struct RotateView: View {
    
    @State private var contained_text: String = ""
    @State private var showPhotoLibrary = false
    
    @State private var image: Image?
    @State private var selectedImage: UIImage?
    var body: some View {
        VStack{
            image?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(4)
                .addRoundBorder(Color.black, width: 2, cornerRadius: 10)
            Button("swap image", action: { self.showPhotoLibrary = true })
            Spacer()
            Button(action: {
                if ((selectedImage) != nil) {
                    contained_text = detect_text(self.selectedImage)
                } else {
                    contained_text = "Please select an image first"
                }
            }) {
                Text("auto rotate")
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
            ImagePicker(selectedImage: self.$selectedImage)
        }
        .padding()
        .navigationTitle("Auto Rotate")
        .onChange(of: selectedImage) { _ in loadImage() }
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
}
