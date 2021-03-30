//
//  WebViewController.swift
//  SportApp
//
//  Created by mac on 3/28/21.
//

import UIKit
import WebKit
class WebViewController: UIViewController {
    var link : String?
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url:URL(string : "https://" + link!)!))
        // Do any additional setup after loading the view.
    }
 

}
