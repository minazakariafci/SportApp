//
//  extensions.swift
//  SportApp
//
//  Created by mac on 3/24/21.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    public func maskCircle() {
      self.contentMode = UIView.ContentMode.scaleAspectFill
      self.layer.cornerRadius = self.frame.height / 2
      self.layer.masksToBounds = false
      self.clipsToBounds = true
    }
}


extension UIImageView {
    
    @IBInspectable
    var imageUrl: String {
        get {
            return ""
        }
        set {
            let url = URL(string: newValue)
            self.kf.setImage(with: url, placeholder: UIImage())
        }
    }
}
