//
//  FullScreenViewController.swift
//  MenusExample
//
//  Created by Omar Albeik on 4/24/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit
import AVFoundation
import Menus

class FullScreenViewController: UIViewController, MenuContainable {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("FullScreenViewController, viewDidLoad")

        view.backgroundColor = .black

        AVCaptureDevice.requestAccess(for: .video) { granted in
            guard granted else { return }
            print(granted)
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("FullScreenViewController, viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("FullScreenViewController, viewDidAppear")

        container?.rightMenu = ScanMenu()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("FullScreenViewController, viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("FullScreenViewController, viewDidDisappear")
    }

}
