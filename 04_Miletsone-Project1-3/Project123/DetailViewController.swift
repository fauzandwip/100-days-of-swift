//
//  DetailViewController.swift
//  Project123
//
//  Created by Fauzan Dwi Prasetyo on 19/04/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let img = selectedImage {
            title = img.uppercased()
            imageView.image = UIImage(named: img)
        }
    }
    
}
