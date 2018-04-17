//
//  OpenSourceViewController.swift
//  MenusExample
//
//  Created by Omar Albeik on 4/17/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit
import Menus

class OpenSourceViewController: UIViewController, MenuContainable {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundColor(.white)
        container?.rightMenu = nil
    }

    @IBAction func didTapLeftBarButtonItem(_ sender: UIBarButtonItem) {
        container?.leftMenu?.toggle()
    }

    @IBAction func didTapVeiwOnGithubButton(_ sender: UIButton) {
        var url: URL? {
            switch sender.tag {
            case 1:
                return URL(string: "https://github.com/MobilionOSS/PieCrust")
            case 2:
                return URL(string: "https://github.com/MobilionOSS/Menus")
            case 3:
                return URL(string: "https://github.com/MobilionOSS/TCNumberValidator")
            default:
                return nil
            }
        }
        guard let repoUrl = url else { return }
        UIApplication.shared.open(repoUrl, options: [:], completionHandler: nil)
    }

}
