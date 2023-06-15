//
//  Picture.swift
//  Project1
//
//  Created by Fauzan Dwi Prasetyo on 05/05/23.
//

import Foundation

class Picture: NSObject, Codable {
    
    var imageName: String
    var views: Int
    
    init(imageName: String, views: Int) {
        self.imageName = imageName
        self.views = views
    }
}
