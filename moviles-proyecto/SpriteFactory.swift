//
//  SpriteFactory.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 10/05/21.
//

struct SpriteFactory {
    static let all: Set = [
        Sprite(name: "Buck", weight: 80, height: 1, weightCategory: .heavyweight, imageURL: "Buck"),
        Sprite(name: "Celeste", weight: 5, height: 0.5, weightCategory: .lightweight, imageURL: "Celeste"),
        Sprite(name: "Steve", weight: 30, height: 1, weightCategory: .middleweight, imageURL: "steve"),
        Sprite(name: "Master Chief", weight: 80, height: 1.0, weightCategory: .heavyweight, imageURL: "masterchief"),
        Sprite(name: "Delmont Walker", weight: 75, height: 0.7, weightCategory: .heavyweight, imageURL: "Delmont Walker"),
        Sprite(name: "Heroe de Oakvale", weight: 15, height: 0.6, weightCategory: .lightweight, imageURL: "Hero of Oakvale Child"),
        Sprite(name: "Horstachio", weight: 40, height: 0.7, weightCategory: .middleweight, imageURL: "Horstachio"),
        Sprite(name: "Inquisidor", weight: 80, height: 0.6, weightCategory: .heavyweight, imageURL: "Inquisidor"),
        Sprite(name: "James Fenix", weight: 75, height: 0.7, weightCategory: .heavyweight, imageURL: "James Fenix"),
        Sprite(name: "Jardiniero", weight: 60, height: 0.7, weightCategory: .middleweight, imageURL: "Jardiniero"),
        Sprite(name: "Kait Diaz", weight: 65, height: 0.7, weightCategory: .heavyweight, imageURL: "Kait Diaz"),
        Sprite(name: "Leafos", weight: 50, height: 0.6, weightCategory: .middleweight, imageURL: "Leafos"),
        Sprite(name: "Marcus Fenix", weight: 75, height: 0.6, weightCategory: .heavyweight, imageURL: "Marcus Fenix"),
        Sprite(name: "Noble Seis", weight: 80, height: 1, weightCategory: .heavyweight, imageURL: "Noble Seis"),
        Sprite(name: "Seedos", weight: 60, height: 0.8, weightCategory: .middleweight, imageURL: "Seedos"),
        Sprite(name: "Rojo", weight: 5, height: 0.4, weightCategory: .middleweight, imageURL: "Rojo"),
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
