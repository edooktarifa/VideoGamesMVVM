//
//  UIImageView+Extensions.swift
//  RAWGVideoGames
//
//  Created by Phincon on 17/08/23.
//

import Foundation
import UIKit

extension UIImageView {
    
    var activityIndicatorTag: Int { return 999_998 }
    
    func showLoadingIndicator() {
        let loadingView = UIActivityIndicatorView()
        loadingView.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        loadingView.startAnimating()
        loadingView.tag = self.activityIndicatorTag
        
        DispatchQueue.main.async {
            self.addSubview(loadingView)
        }
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            if let loadingView = self.viewWithTag(self.activityIndicatorTag) as? UIActivityIndicatorView {
                loadingView.removeFromSuperview()
            }
        }
    }
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        showLoadingIndicator()
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return self.hideLoadingIndicator()}
            DispatchQueue.main.async() { [weak self] in
                self?.hideLoadingIndicator()
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
