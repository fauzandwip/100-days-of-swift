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
        
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let pos = position, let tot = total {
            title = "Picture \(pos) of \(tot)"
        }
        
        if let imageToLoad = selectedImage {
            drawImagesAndText(imgName: imageToLoad)
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

    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No Image Found")
            return
        }
        
        let text = selectedImage!
        
        let vc = UIActivityViewController(activityItems: [image, text], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    func drawImagesAndText(imgName: String) {

        let imageViewWidth = imageView.frame.size.width
        let imageViewHeight = imageView.frame.size.height
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: imageViewWidth, height: imageViewHeight))
        
        let image = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 20),
                .foregroundColor: UIColor.red,
                .paragraphStyle: paragraphStyle
            ]
            
            let string = "From Storm Viewer"
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            
            if let image = UIImage(named: imgName) {
                let imageWidth = image.size.width
                let imageHeight = image.size.height
                
                let aspectFillRatio = max(imageViewWidth / imageWidth, imageViewHeight / imageHeight)
                
                let scaledWidth = imageWidth * aspectFillRatio
                let scaledHeight = imageHeight * aspectFillRatio
                
                let imageX = (imageViewWidth - scaledWidth) / 2
                let imageY = (imageViewHeight - scaledHeight) / 2
                
//                ctx.cgContext.clip(to: CGRect(origin: .zero, size: imageView.frame.size))
                
                image.draw(in: CGRect(x: imageX, y: imageY, width: scaledWidth, height: scaledHeight))
            }
            
            
            attributedString.draw(with: CGRect(x: imageViewWidth / 2 - 100, y: imageViewHeight / 2 - 20, width: 200, height: 200),options: .usesLineFragmentOrigin, context: nil)
            
        }
         
        imageView.image = image

    }
    
}
