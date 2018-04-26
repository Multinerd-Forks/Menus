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
        print("OpenSourceViewController, viewDidLoad")

        navigationController?.navigationBar.setBackgroundColor(.white)
        container?.rightMenu = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("OpenSourceViewController, viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("OpenSourceViewController, viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("OpenSourceViewController, viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("OpenSourceViewController, viewDidDisappear")
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
