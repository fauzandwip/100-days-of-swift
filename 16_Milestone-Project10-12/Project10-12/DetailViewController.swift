//
//  DetailViewController.swift
//  Project10-12
//
//  Created by Fauzan Dwi Prasetyo on 05/05/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedPhoto: Photo?
    var path: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedPhoto?.caption
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let url = path {
            if let imageData = try? Data(contentsOf: url) {
                let image = UIImage(data: imageData)
                imageView.image = image
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            fatalError("No image found")
        }
        
        let text = selectedPhoto?.caption ?? ""
        
        let vc = UIActivityViewController(activityItems: [image, text], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}
