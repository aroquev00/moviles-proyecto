//
//  SpriteFactory.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 10/05/21.
//

struct SpriteFactory {
    static let all: Set = [
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
    
    static func getRandomWeightForSprite(sprite: Sprite) -> Float {
        switch sprite.weightCategory {
        case .lightweight:
            return Float(Int.random(in: 1..<20))
        case .middleweight:
            return Float(Int.random(in: 20...60))
        case .heavyweight:
            return Float(Int.random(in: 61...100))
        default:
            return Float(Int.random(in: 1...100))
        }
    }
    
    static func getRandomUnusedSpriteForWeightCategory(availableSprites: Set<Sprite>, weightCategory: WeightCategory) -> Sprite {
        let candidateSprites = availableSprites.filter { sprite in
            sprite.weightCategory == weightCategory
        }
        if candidateSprites.isEmpty {
            switch weightCategory {
            case .lightweight:
                return lightweights.randomElement()!
            case .middleweight:
                return middleweights.randomElement()!
            case .heavyweight:
                return heavyweights.randomElement()!
            default:
                return all.randomElement()!
            }
        }
        else {
            return candidateSprites.randomElement()!
        }
    }
}
