//
//  TextRecognition.swift
//  wonda
//
//  Created by mp on 13/12/2021.
//

import SwiftUI
import Vision


func detect_text(_ image: UIImage?) -> String {
    var recognisedText: String = "";

    guard let cgImage = image?.cgImage else { return "ERR getting cgImage" }
    
    let req_handler = VNImageRequestHandler(cgImage: cgImage)
    
    let req = VNRecognizeTextRequest(completionHandler: {(req, err) in
        guard let obs = req.results as? [VNRecognizedTextObservation] else { return }
        
        let found_strings = obs.compactMap{ obs in
            return obs.topCandidates(1).first?.string
        }.joined(separator: " ")
        
        recognisedText = found_strings
    })
    
    do {
        try req_handler.perform([req])
    } catch {
        print("Unable to perform reqs: \(error).")
    }
    
    return recognisedText
}


