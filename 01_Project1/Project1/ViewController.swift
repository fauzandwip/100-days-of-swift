//
//  ViewController.swift
//  Project1
//
//  Created by Fauzan Dwi Prasetyo on 18/04/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [Picture]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let savedData = defaults.object(forKey: "pictures") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                pictures = try jsonDecoder.decode([Picture].self, from: savedData)
            } catch {
                print("Failed to load pictures.")
            }
        }
        
//        let fm = FileManager.default
//        let path = Bundle.main.resourcePath!
//        var items = try! fm.contentsOfDirectory(atPath: path)
//
//        items.sort()
//        for item in items {
//            if item.hasPrefix("nssl") {
//                var picture = Picture(imageName: item, views: 0)
//                pictures.append(picture)
//            }
//        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let picture = pictures[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = picture.imageName
        content.secondaryText = String(picture.views)
        cell.contentConfiguration = content
        
//        pictures.sort()
        // deprecated in future
        cell.textLabel?.text = picture.imageName
        cell.detailTextLabel?.text = String(picture.views)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let picture = pictures[indexPath.row]
        
        picture.views += 1
        saveData()
        tableView.reloadData()
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = picture.imageName
            vc.total = pictures.count
            vc.position = indexPath.row + 1
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }

    func saveData() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let savedData = try jsonEncoder.encode(pictures)
            defaults.set(savedData, forKey: "pictures")
        } catch {
            print("Failed to save picture.")
        }
    }
}
