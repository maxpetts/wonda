//
//  TextRecognition.swift
//  wonda
//
//  Created by mp on 13/12/2021.
//

import SwiftUI
import Vision

var recognisedText: String = "";

func detect_text(_ image: UIImage?) -> String {
    guard let cgImage = image?.cgImage else { return "ERR getting cgImage" }
    
    let req_handler = VNImageRequestHandler(cgImage: cgImage)
    
    let req = VNRecognizeTextRequest(completionHandler: completed_text_req)
    
    do {
        try req_handler.perform([req])
    } catch {
        print("Unable to get reqs: \(error).")
    }
    
    return recognisedText
}

func completed_text_req(req: VNRequest, err: Error?) {
    guard let obs = req.results as? [VNRecognizedTextObservation] else { return }
    
    let found_strings = obs.compactMap{ obs in
        return obs.topCandidates(1).first?.string
    }.joined(separator: " ")
    
    recognisedText = found_strings
}
