//
//  Extensions.swift
//  MenusExample
//
//  Created by Omar Albeik on 4/17/18.
//  Copyright © 2018 Mobilion. All rights reserved.
//

import UIKit

extension UINavigationBar {

    func setBackgroundColor(_ color: UIColor) {
        isTranslucent = true
        backgroundColor = color
        barTintColor = color
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
    }

}
