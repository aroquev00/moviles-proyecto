//
//  Sprite.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 25/03/21.
//

import UIKit

class Sprite: NSObject, Codable {

    var name: String
    var weight: Float
    var height: Float
    var imageURL: String
    
    init(name: String, weight: Float, height: Float, imageURL: String) {
        self.name = name
        self.weight = weight
        self.height = height
        self.imageURL = imageURL
    }
}
