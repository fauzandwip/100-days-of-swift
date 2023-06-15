//
//  DetailViewController.swift
//  Project7
//
//  Created by Fauzan Dwi Prasetyo on 30/04/23.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var detailPetition: Petition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("oke")
        guard let detailPetition = detailPetition else { return }
        
        let html = """
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style> p { font-size: 150%; } </style>
</head>
<body>
<h1>
\(detailPetition.title)
</h1>
<h3>
Signature: \(detailPetition.signatureCount)
</h3>
<p>
\(detailPetition.body)
</p>
</body>
</html>
"""
        
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
}


