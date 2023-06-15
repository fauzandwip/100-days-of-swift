//
//  DetailViewController.swift
//  Project13-15
//
//  Created by Fauzan Dwi Prasetyo on 08/05/23.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var countrylabel: UILabel!
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var presidentLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    var countryName = ""
    var capital = ""
    var president = ""
    var language = ""
    var currency = ""
    var area = ""
    var population = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countrylabel.text = countryName
        flagImage.image = UIImage(named: "flag" + countryName.replacingOccurrences(of: " ", with: ""))
        capitalLabel.text = "Capital: \(capital)"
        presidentLabel.text = "President: \(president)"
        languageLabel.text = "Language: \(language)"
        currencyLabel.text = "Currency: \(currency)"
        areaLabel.text = "Area: \(area)"
        populationLabel.text = "Population: \(String(population))"
        flagImage.layer.borderColor = CGColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
        flagImage.layer.borderWidth = 1
        
    }

}
