//
//  SimulatorSpot.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 02/04/21.
//

struct SimulatorSpot: Hashable {
    var side: Bool // Left is false, right is true
    var distance: Float // Distance from centre
    var sprite: Sprite? // The sprite placed in it
}
