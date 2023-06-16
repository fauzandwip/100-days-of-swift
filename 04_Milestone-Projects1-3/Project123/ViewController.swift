//
//  ViewController.swift
//  Project123
//
//  Created by Fauzan Dwi Prasetyo on 19/04/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        flags += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let flagName = flags[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlagCell", for: indexPath)
        cell.textLabel?.text = flagName.capitalized
        cell.imageView?.image = UIImage(named: flagName)
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        
//        cell.layer.borderWidth = 1
//        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.imageView?.translatesAutoresizingMaskIntoConstraints = false
        cell.imageView?.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 20).isActive = true
        cell.imageView?.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10).isActive = true
        cell.imageView?.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -10).isActive = true
        cell.imageView?.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.selectedImage = flags[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

