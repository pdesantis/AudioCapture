//
//  ViewController.swift
//  AudioCapture
//
//  Created by Patrick DeSantis on 10/8/20.
//

import AVFoundation
import Cocoa

class ViewController: NSViewController {
    
    private let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "session-queue")
    private let writerQueue = DispatchQueue(label: "writer-queue")

    override func viewDidLoad() {
        super.viewDidLoad()

        sessionQueue.async {
            do {
                try self.setupSession()
                self.captureSession.startRunning()
            } catch {
                print(error)
            }
        }
    }
    
    func setupSession() throws {
        captureSession.beginConfiguration()
        defer {
            captureSession.commitConfiguration()
        }
        
        guard let device = AVCaptureDevice.default(for: .audio) else {
            print("No default audio capture device found")
            return
        }
                
        let input = try AVCaptureDeviceInput(device: device)
        captureSession.addInput(input)
        
        let output = AVCaptureAudioDataOutput()
        output.setSampleBufferDelegate(self, queue: writerQueue)
        captureSession.addOutput(output)
    }

}

extension ViewController: AVCaptureAudioDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
    }
}
