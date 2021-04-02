//
//  Simulator.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 02/04/21.
//

import UIKit

class Simulator: NSObject {
    
    var spots: [SimulatorSpot]

    override init() {
        spots = []
        for dist in stride(from: 2, to: 0, by: -0.25) {
            spots.append(SimulatorSpot(side: false, distance: Float(dist)))
        }
        for dist in stride(from: 0.25, through: 2, by: 0.25) {
            spots.append(SimulatorSpot(side: true, distance: Float(dist)))
        }
        print(spots.count)
    }
}
