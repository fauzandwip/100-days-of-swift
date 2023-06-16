//
//  ViewController.swift
//  Project10-12
//
//  Created by Fauzan Dwi Prasetyo on 05/05/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var picker = UIImagePickerController()
    var photos = [Photo]()

    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photo Gallery"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(addPhoto))
        
        pickerSetting()
        
        loadData()
    }
    
    @objc func addPhoto() {
        present(picker, animated: true)
    }
    
    func loadData() {
        if let savedData = defaults.object(forKey: "photos") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                photos = try jsonDecoder.decode([Photo].self, from: savedData)
            } catch {
                print("Failed to load photos.")
            }
        }
    }
    
    func saveData() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let savedData = try jsonEncoder.encode(photos)
            defaults.set(savedData, forKey: "photos")
        } catch {
            print("Failed to save photos.")
        }
    }
    
}


// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate method

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func pickerSetting() {
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageName = UUID().uuidString
        
        if let image = info[.editedImage] as? UIImage,
           let imageData = image.jpegData(compressionQuality: 0.8) {
            let url = getDocumentsDirectory().appending(path: imageName)
            
            do {
                try imageData.write(to: url)
            } catch {
                fatalError("Failed write image data.")
            }
        }
        
        dismiss(animated: true)
        
        addCaption(imageName)
        
    }
    
    func addCaption(_ imageName: String) {
        let ac = UIAlertController(title: "Caption", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let caption = ac?.textFields?[0].text else { return }
            
            let photo = Photo(imageName: imageName, caption: caption)
            self?.photos.insert(photo, at: 0)
            self?.saveData()
            
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .fade)
        })
        
        present(ac, animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}


// MARK: - UITableViewController method

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photo = photos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath)
        
        cell.textLabel?.text = photo.caption
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedPhoto = photo
            vc.path = getDocumentsDirectory().appending(path: photo.imageName)
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
