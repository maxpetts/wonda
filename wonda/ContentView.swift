//
//  ContentView.swift
//  wonda
//
//  Created by mp on 23/11/2021.
//

import SwiftUI
import Vision

struct ContentView: View {
    
    @State private var contained_text: String = ""
    
    var body: some View {
        VStack{
            Image(uiImage: UIImage(named: "testimage1")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(4)
                .addRoundBorder(Color.black, width: 2, cornerRadius: 10)
            Button("swap image", action: {})
            Spacer()
            Button("get text", action: {detect_text(UIImage(named: "testimage1"))})
            Text(contained_text)
            Spacer()
            Text("By Max Petts (not a designer)")
                .font(.caption2)
                .foregroundColor(Color.gray)
        }.padding()
    }
    
    func detect_text(_ image: UIImage?) {
        guard let cgImage = image?.cgImage else { return }
        
        let req_handler = VNImageRequestHandler(cgImage: cgImage)
        
        let req = VNRecognizeTextRequest(completionHandler: completed_text_req)
        
        do {
            try req_handler.perform([req])
        } catch {
            print("Unable to get reqs: \(error).")
        }
    }

    func completed_text_req(req: VNRequest, err: Error?) {
        guard let obs = req.results as? [VNRecognizedTextObservation] else {return}
        
        let found_strings = obs.compactMap{ obs in
            return obs.topCandidates(1).first?.string
        }.joined(separator: " ")
        
        contained_text = found_strings
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


