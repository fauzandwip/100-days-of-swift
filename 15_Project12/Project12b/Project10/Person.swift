//
//  Person.swift
//  Project10
//
//  Created by Fauzan Dwi Prasetyo on 03/05/23.
//

import UIKit

class Person: NSObject, NSCoding {

    var name: String
    var imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
    required init(coder aCoder: NSCoder) {
        name = aCoder.decodeObject(forKey: "name") as? String ?? ""
        imageName = aCoder.decodeObject(forKey: "imageName") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(imageName, forKey: "imageName")
    }
}
