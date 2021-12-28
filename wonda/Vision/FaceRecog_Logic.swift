//
//  TextRecognition.swift
//  wonda
//
//  Created by mp on 13/12/2021.
//

import Foundation
import UIKit
import SwiftUI
import Vision

class FaceDetector: ObservableObject {
    @Published var faces: [VNFaceObservation] = [] {
        willSet{
            objectWillChange.send()
        }
    }
    
    enum FaceDetectorError: Error {
        case loadingImageError
        case noFacesDetected
    }

    func findFaces(UIImage: UIImage) throws -> [VNFaceObservation] {
        guard let cgImage = UIImage.cgImage else { throw FaceDetectorError.loadingImageError }
        
        let req = VNDetectFaceRectanglesRequest()
        
        let req_handler = VNImageRequestHandler(cgImage: cgImage)
        do {
            try req_handler.perform([req])
        } catch {
            print("Unable to perform reqs: \(error).")
        }
        
        guard let results = req.results as? [VNFaceObservation] else {
            throw FaceDetectorError.noFacesDetected
        }
        
        self.faces = results
        return results
    }
    
    func faceDetect(UIImage: UIImage){
            guard let CGImageToProcess = UIImage.cgImage else { return }
            
            let detectedFacesRequest  = VNDetectFaceRectanglesRequest()
            let requestHandler = VNImageRequestHandler(cgImage: CGImageToProcess)
            do{
                try requestHandler.perform([detectedFacesRequest])
            } catch let error as NSError {
                print(error)
            }
            
            guard let detectedFaces = detectedFacesRequest.results as? [VNFaceObservation] else { return }
            self.faces = detectedFaces
        }
}

