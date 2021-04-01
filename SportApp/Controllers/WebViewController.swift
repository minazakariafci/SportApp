//
//  WebViewController.swift
//  SportApp
//
//  Created by mac on 3/28/21.
//

import UIKit
import WebKit
import JGProgressHUD
class WebViewController: UIViewController {
    var link : String = ""
    let hud = JGProgressHUD()
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hud.show(in: self.view)
        webView.load(URLRequest(url:URL(string : "https://" + link)!))
        self.hud.dismiss()
        }
 

}
