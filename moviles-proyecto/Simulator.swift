//
//  Simulator.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 02/04/21.
//

struct Simulator {
    
    var spots: [SimulatorSpot]
    var totalTorque: Float {
        var torque: Float = 0.0
        for spot in spots {
            if let sprite = spot.sprite {
                let selfTorque = sprite.weight * spot.distance
                if spot.side {
                    torque += selfTorque
                } else {
                    torque -= selfTorque
                }
            }
        }
        return torque
    }
    
    init() {
        spots = []
        var index = 0
        for dist in stride(from: 2, to: 0, by: -0.25) {
            spots.append(SimulatorSpot(index: index, side: false, distance: Float(dist)))
            index += 1
        }
        for dist in stride(from: 0.25, through: 2, by: 0.25) {
            spots.append(SimulatorSpot(index: index, side: true, distance: Float(dist)))
            index += 1
        }
        
        //totalTorque = 0.0
    }
}