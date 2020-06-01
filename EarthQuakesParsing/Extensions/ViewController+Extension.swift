//
//  ViewController+Extension.swift
//  EarthQuakesParsing
//
//  Created by tejasree vangapalli on 6/1/20.
//  Copyright © 2020 tejasree vangapalli. All rights reserved.
//

import UIKit

extension UIViewController {
    // Alert controller to display errors
    func ErrorMessage(titleStr:String, messageStr:String) {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
