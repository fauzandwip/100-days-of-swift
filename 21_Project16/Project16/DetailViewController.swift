//
//  DetailViewController.swift
//  Project16
//
//  Created by Fauzan Dwi Prasetyo on 09/05/23.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webViewContainer: UIView!
    
    var webView: WKWebView!
    var capitalName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let noSpaceStr = capitalName?.replacingOccurrences(of: " ", with: "_") ?? "Jakarta"
        let website = "https://id.wikipedia.org/wiki/\(noSpaceStr)"
        
        if let url = URL(string: website) {
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
        
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

}
