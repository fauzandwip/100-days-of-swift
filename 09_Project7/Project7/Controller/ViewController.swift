//
//  ViewController.swift
//  Project7
//
//  Created by Fauzan Dwi Prasetyo on 30/04/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var backUpPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Credit", style: .plain, target: self, action: #selector(getCredit))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(containText))

        getData()
    }
    
    @objc func getCredit() {
        let ac = UIAlertController(title: "Credit :", message: "The data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(ac, animated: true)
    }
    
    @objc func containText() {
        let ac = UIAlertController(title: "Type text...", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let word = ac?.textFields?[0].text else { return }
            self?.submit(word)
        }
        ac.addAction(submitAction)
        
        present(ac, animated: true)
    }
    
    func submit(_ word: String) {
        petitions.removeAll()
        
        for filter in backUpPetitions {
            if filter.title.contains(word) {
                petitions.append(filter)
                continue
            }
            if filter.body.contains(word) {
                petitions.append(filter)
            }
        }
        
        tableView.reloadData()
    }

    func getData() {
        var urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        showError()
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            backUpPetitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(ac, animated: true)
    }

}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let petition = petitions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailPetition = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
