//
//  SimulatorSpot.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 02/04/21.
//

struct SimulatorSpot: Hashable, Codable {
    var index: Int
    var side: Side
    var distance: Float // Distance from centre
    var sprite: Sprite? // The sprite placed in it
    
    // Quiz/Lab attributes
    var isLocked = false
    var showWeight = true
}
