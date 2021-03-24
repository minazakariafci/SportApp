//
//  extensions.swift
//  SportApp
//
//  Created by mac on 3/24/21.
//

import Foundation
import UIKit

extension UIImageView {
    public func maskCircle() {
      self.contentMode = UIView.ContentMode.scaleAspectFill
      self.layer.cornerRadius = self.frame.height / 2
      self.layer.masksToBounds = false
      self.clipsToBounds = true
    }
}
