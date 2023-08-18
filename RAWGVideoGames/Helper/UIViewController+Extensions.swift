//
//  UIViewController+Extensions.swift
//  RAWGVideoGames
//
//  Created by Phincon on 17/08/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, actionTitle: String = "OK", completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            completion?()
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func showLoading(){
        Indicator.sharedInstance.showIndicator()
    }
    
    func hideLoading(){
        Indicator.sharedInstance.hideIndicator()
    }
}


