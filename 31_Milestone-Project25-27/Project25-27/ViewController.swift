//
//  ViewController.swift
//  Project25-27
//
//  Created by Fauzan Dwi Prasetyo on 16/05/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var importPhotoButton: UIButton!
    @IBOutlet weak var topTextButton: UIButton!
    @IBOutlet weak var bottomTextButton: UIButton!
    
    var image: UIImage? = nil
    var textTop = ""
    var textBottom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    func setupUI() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationController?.navigationBar.tintColor = .black
        
        importPhotoButton.layer.borderWidth = 3
        importPhotoButton.layer.borderColor = UIColor.darkGray.cgColor
        importPhotoButton.backgroundColor = UIColor.darkGray
        importPhotoButton.setTitleColor(.white, for: .normal)
        importPhotoButton.layer.cornerRadius = 10
        
        topTextButton.layer.borderWidth = 3
        topTextButton.layer.borderColor = UIColor.darkGray.cgColor
        topTextButton.backgroundColor = UIColor.darkGray
        topTextButton.setTitleColor(.white, for: .normal)
        topTextButton.layer.cornerRadius = 10
        
        bottomTextButton.layer.borderWidth = 3
        bottomTextButton.layer.borderColor = UIColor.darkGray.cgColor
        bottomTextButton.backgroundColor = UIColor.darkGray
        bottomTextButton.setTitleColor(.white, for: .normal)
        bottomTextButton.layer.cornerRadius = 10
    }

    @IBAction func importPhotoTapped(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        
        imageView.image = image
        self.image = image
        addText()
    }
    
    @IBAction func topTextTapped(_ sender: Any) {
        if self.image == nil {
            shouldImportPhoto()
        } else {
            let ac = UIAlertController(title: "Type text for the top", message: nil, preferredStyle: .alert)
            ac.addTextField()
            ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] action in
                guard let text = ac.textFields?[0].text else { return }
                self?.textTop = text
                self?.addText()
            })
            
            present(ac, animated: true)
        }
    }
    
    @IBAction func bottomTextTapped(_ sender: UIButton) {
        if self.image == nil {
            shouldImportPhoto()
        } else {
            let ac = UIAlertController(title: "Type text for the bottom", message: nil, preferredStyle: .alert)
            ac.addTextField()
            ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                guard let text = ac.textFields?[0].text else { return }
                self?.textBottom = text
                self?.addText()
            })
            
            present(ac, animated: true)
        }
    }
    
    @objc func shareTapped() {
            if let image = imageView.image {
                let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
                vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
                present(vc, animated: true)
            }
            
    }
    
    func shouldImportPhoto() {
        let ac = UIAlertController(title: "Need photo", message: "You have to import photo using the Import Photo Button", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(ac, animated: true)
        
    }
    
    func addText() {
        let imageViewWidth = imageView.frame.size.width
        let imageViewHeight = imageView.frame.size.height
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: imageViewWidth, height: imageViewHeight))
        
        let image = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 25, weight: .semibold),
                .foregroundColor: UIColor.cyan,
                .paragraphStyle: paragraphStyle,
            ]
            
            var attributedString = NSAttributedString(string: textTop, attributes: attrs)
            
            let imageFitSize = AVMakeRect(aspectRatio: self.image!.size, insideRect: self.imageView.bounds)
            self.image!.draw(in: imageFitSize)
            
            // position and size for text
            let strX = ((self.imageView.bounds.width - imageFitSize.width) / 2) + 10
            var strY = ((self.imageView.bounds.height - imageFitSize.height) / 2) + 10
            let strWidth = imageFitSize.width - 30
            let strHeight = imageFitSize.height - 30
            
            // for top text
            attributedString.draw(with: CGRect(x: strX, y: strY, width: strWidth, height: strHeight), options: .usesLineFragmentOrigin, context: nil)
            
            // for bottom text
            attributedString = NSAttributedString(string: textBottom, attributes: attrs)
            strY += imageFitSize.height - 50
            attributedString.draw(with: CGRect(x: strX, y: strY, width: strWidth, height: strHeight), options: .usesLineFragmentOrigin, context: nil)
        }
        
        imageView.image = image
    }
}

