//
//  TextRecognition.swift
//  wonda
//
//  Created by mp on 13/12/2021.
//

import Vision
import AVFoundation

func getSession() {
    let capSes = AVCaptureSession()

    guard let videoDevice = AVCaptureDevice.default(for: .video) else { return }
    
    do {
        let videoInput = try AVCaptureDeviceInput(device: videoDevice)
        
        if capSes.canAddInput(videoInput) {
            capSes.addInput(videoInput)
        }
    } catch {
        fatalError("Me no know")
    }
}

func findFace() {
    var handler = VNSequenceRequestHandler()
    
}
