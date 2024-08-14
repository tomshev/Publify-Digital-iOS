//
//  QRCodeScannerVM.swift
//  Publify Digital
//
//  Created by Tom Sevcov on 10/07/2024.
//

import SwiftUI
import AVFoundation

struct QRCodeScannerVM: UIViewControllerRepresentable {
    
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: QRCodeScannerVM
        
        init(parent: QRCodeScannerVM) {
            self.parent = parent
        }
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                parent.didFindCode(stringValue)
            }
        }
    }
    
    var didFindCode: (String) -> Void
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        // If running in Xcode simulator and not actual iPhone,
        // pretending that QR code has been scanned and it's value SimulatedQRCode1234
        #if targetEnvironment(simulator)
        let viewController = UIViewController()
        let label = UILabel()
        label.text = "Simulated QR Code"
        label.textAlignment = .center
        label.frame = viewController.view.frame
        viewController.view.addSubview(label)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.didFindCode("SimulatedQRCode1234")
        }
        return viewController
        #else
        let viewController = UIViewController()
        
        // Requesting camera permissions
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setupCaptureSession(in: viewController, context: context)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.setupCaptureSession(in: viewController, context: context)
                    }
                } else {
                    print("Camera access denied")
                }
            }
        default:
            print("Camera access denied or restricted")
        }
        
        return viewController
        #endif
    }
    
    private func setupCaptureSession(in viewController: UIViewController, context: Context) {
        let captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print("Failed to get the camera device")
            return
        }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            print("Error creating video input: \(error.localizedDescription)")
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            print("Failed to add video input to the session")
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            print("Failed to add metadata output to the session")
            return
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(previewLayer)
        
        DispatchQueue.main.async {
            previewLayer.frame = CGRect(x: (viewController.view.frame.width - 250) / 2,
                                        y: (viewController.view.frame.height - 250) / 2,
                                        width: 250,
                                        height: 250)
        }
        
        // Small issue because calling not from background thread, not critical
        captureSession.startRunning()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct QRCodeScannerVM_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScannerVM { _ in }
    }
}



