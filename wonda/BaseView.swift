//
//  BaseView.swift
//  wonda
//
//  Created by mp on 14/12/2021.
//

import SwiftUI

struct BaseView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    TextRecognitionView()
                } label: {
                    Image(systemName: "a.magnify")
                    Text("Text Recognition")
                }
                NavigationLink {
                    RotateView()
                } label: {
                    Image(systemName: "arrow.clockwise.circle")
                    Text("Auto Rotate Image")
                }
                NavigationLink {
                    FaceRecognitionView()
                        .environmentObject(FaceDetector())
                } label: {
                    Image(systemName: "face.dashed")
                    Text("Face Recognition")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image(systemName: "eye.fill").font(.largeTitle)
                        Text("Wonda Vision").font(.title)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
