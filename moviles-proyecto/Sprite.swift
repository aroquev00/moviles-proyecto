//
//  Sprite.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 25/03/21.
//

import UIKit

class Sprite: NSObject {

    var name: String
    var weight: Float
    var height: Float
    var image: UIImage?
    
    init(name: String, weight: Float, height: Float, image: UIImage?) {
        self.name = name
        self.weight = weight
        self.height = height
        self.image = image
    }
}
