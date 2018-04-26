//
//  ScanMenu.swift
//  MenusExample
//
//  Created by Omar Albeik on 4/24/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit
import AVFoundation
import Menus

class ScanMenu: UIViewController, MenuType {

    var container: MenuContainer!

    var shouldCloseWhenTappingCurrentView: Bool = true

    weak var delegate: MenuDelegate?

    var side: MenuSide {
        return .right
    }

    var interactiveSwipeMargin: CGFloat {
        return UIScreen.main.bounds.width
    }

    var menuWidth: CGFloat {
        return UIScreen.main.bounds.width - 50
    }

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ScanMenu, viewDidLoad")

        view.backgroundColor = .black
        captureSession = AVCaptureSession()

        guard let device = AVCaptureDevice.default(for: .video) else { return }
        let input: AVCaptureDeviceInput

        do {
            input = try AVCaptureDeviceInput(device: device)
        } catch {
            print(error.localizedDescription)
            failed()
            return
        }

        if captureSession.canAddInput(input) {
            captureSession.addInput(input)
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ScanMenu, viewWillAppear")

        if captureSession?.isRunning == false {
            captureSession?.startRunning()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ScanMenu, viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ScanMenu, viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ScanMenu, viewDidDisappear")

        if captureSession?.isRunning == true {
            captureSession?.stopRunning()
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

}

extension ScanMenu: AVCaptureMetadataOutputObjectsDelegate {

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let metadataObject = metadataObjects.first else { return }
        guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
        guard let stringValue = readableObject.stringValue else { return }
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        found(code: stringValue)
        close()
    }

}

// MARK: - Helpers
private extension ScanMenu {

    func found(code: String) {
        print(code)
    }

    func failed() {
        let alert = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        captureSession = nil
    }

}
