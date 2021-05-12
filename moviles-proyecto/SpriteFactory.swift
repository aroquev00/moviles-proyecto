//
//  SpriteFactory.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 10/05/21.
//

struct SpriteFactory {
    static let all = [
        Sprite(name: "Mario", weight: 20, height: 1, weightCategory: .middleweight, imageURL: "mario"),
        Sprite(name: "Kirby", weight: 10, height: 0.4, weightCategory: .lightweight, imageURL: "kirby"),
        Sprite(name: "Steve", weight: 30, height: 1, weightCategory: .middleweight, imageURL: "steve"),
        Sprite(name: "Master Chief", weight: 80, height: 1.0, weightCategory: .middleweight, imageURL: "masterchief"),
        Sprite(name: "Plankton", weight: 5, height: 0.5, weightCategory: .lightweight, imageURL: "plankton"),
        Sprite(name: "Sonic", weight: 15, height: 0.6, weightCategory: .lightweight, imageURL: "sonic"),
        Sprite(name: "Link", weight: 60, height: 0.85, weightCategory: .heavyweight, imageURL: "link"),
        Sprite(name: "Megaman", weight: 20, height: 1, weightCategory: .middleweight, imageURL: "megaman")
    ]
    
    static var lightweights: Set<Sprite> = getWeightSet(weightCategory: .lightweight)
    static var middleweights: Set<Sprite> = getWeightSet(weightCategory: .middleweight)
    static var heavyweights: Set<Sprite> = getWeightSet(weightCategory: .heavyweight)
    
    
    private static func getWeightSet(weightCategory: WeightCategory) -> Set<Sprite> {
        let filteredArray = all.filter { sprite in
            sprite.weightCategory == weightCategory
        }
        return Set(filteredArray)
    }
}
