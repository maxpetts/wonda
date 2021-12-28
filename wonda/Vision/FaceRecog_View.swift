//
//  ContentView.swift
//  wonda
//
//  Created by mp on 23/11/2021.
//

import SwiftUI
import Vision

struct FaceRecognitionView: View {
    
    @State private var contained_text: String = ""
    @State private var showPhotoLibrary = false
    @EnvironmentObject var faceDectector: FaceDetector
    @State private var faces: [VNFaceObservation] = []
    
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
                .overlay(facesView)
            Button("swap image", action: { self.showPhotoLibrary = true })
            Spacer()
            Button(action: {
                if ((selectedImage) != nil) {
                    contained_text = ""
                    do {
                        try faces = faceDectector.findFaces(UIImage: selectedImage!)
                    }
                    catch { print("error doing face") }
                } else {
                    contained_text = "Please select an image first"
                }
            }) {
                Text("find face(s)")
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
        .navigationTitle("Face Recognition")
        .onChange(of: selectedImage) { _ in loadImage()}
    }
    
    var facesView: some View {
        ZStack {
            if faces.isEmpty {
                Text("NON FOUND")
            }
            ForEach(faces, id: \.self) {
                face in GeometryReader { geom in
                    Rectangle()
                        .rotation(.radians(-Double(truncating: face.roll ?? 0)), anchor: .center)
                        .path(in: drawRect(on: face, size: geom.size))
                        .stroke(Color.red, lineWidth: 2.5)
                }
            }
        }
    }
    
    func loadImage() {
        faces = []
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
        do {
            try faceDectector.findFaces(UIImage: selectedImage)
        } catch {print("err finding faces")}
    }
    
    func drawRect(on face: VNFaceObservation, size: CGSize) -> CGRect {
        let rect = CGRect(
            x: face.boundingBox.minX * size.width,
            y: ((1 - face.boundingBox.maxY) * size.height),
            width:  face.boundingBox.width * size.width,
            height:  face.boundingBox.height * size.height)
        return rect
    }
}
