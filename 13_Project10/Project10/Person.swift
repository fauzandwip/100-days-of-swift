//
//  Person.swift
//  Project10
//
//  Created by Fauzan Dwi Prasetyo on 03/05/23.
//

import UIKit

class Person: NSObject {

    var name: String
    var imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
