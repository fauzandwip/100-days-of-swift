//
//  ViewController.swift
//  Project13-15
//
//  Created by Fauzan Dwi Prasetyo on 08/05/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        loadData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = countries[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        cell.textLabel?.text = country.name
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries[indexPath.row]
        
        if let vc = storyboard?.instantiateViewController(identifier: "DetailCountry") as? DetailViewController {
            vc.countryName = country.name
            vc.capital = country.capital
            vc.president = country.president
            vc.language = country.language
            vc.currency = country.currency
            vc.area = country.area
            vc.population = country.population
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func loadData() {
        
        if let url = Bundle.main.url(forResource: "countryList", withExtension: ".json") {
            if let jsonData = try? Data(contentsOf: url) {
                parse(jsonData)
            }
        }
        
    }
    
    func parse(_ json: Data) {
        let decoder = JSONDecoder()
        
        do {
            let countries = try decoder.decode(Countries.self, from: json)
            for country in countries.countries {
                self.countries.append(country)
            }
        } catch {
            print("Failed to load json file, \(error)")
        }
    }

}

