//
//  DetailViewController.swift
//  Project1
//
//  Created by Fauzan Dwi Prasetyo on 18/04/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var selectedImage: String?
    var total: Int?
    var position: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(selectedImage != nil, "selectedImage no have value")
        
        if let pos = position, let tot = total {
            title = "Picture \(pos) of \(tot)"
        }
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
