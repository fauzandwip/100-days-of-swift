//
//  Countries.swift
//  Project13-15
//
//  Created by Fauzan Dwi Prasetyo on 08/05/23.
//

import Foundation

struct Countries: Decodable {
    var countries: [Country]
}

struct Country: Decodable {
    var name: String
    var capital: String
    var president: String
    var language: String
    var currency: String
    var area: String
    var population: Int
}
