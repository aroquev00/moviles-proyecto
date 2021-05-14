//
//  MassEstimationQuestion.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

struct MassEstimationQuestion: QuizQuestion {
    var level: Int
    var simulator: Simulator
    var answerStatus: AnswerStatus
    var questionSprite: Sprite?
    var answerWeight: Float
    
    init(level: Int) {
        self.level = level
        simulator = Simulator(quizMode: true)
        answerStatus = .unanswered
        answerWeight = 0 // Placeholder value
        generateQuestion()
    }
    
    mutating func checkAnswer() {
        if answerWeight == questionSprite?.weight {
            answerStatus = .correct
            print("correcto")
        } else {
            answerStatus = .incorrect
            print("incorrecto")
        }
    }
    
    mutating func generateQuestion() {
        var availableSprites = SpriteFactory.all
        
        var availableSpots = Set(0...15)
        var usedSpots: Set<Int> = Set()
        
        func placeRandomSprite() {
            let spotIndex = availableSpots.randomElement()!
            availableSpots.remove(spotIndex)
            usedSpots.insert(spotIndex)
            
            var sprite = availableSprites.randomElement()!
            availableSprites.remove(sprite)
            sprite.weight = SpriteFactory.getRandomWeightForSprite(sprite: sprite)
            
            self.simulator.spots[spotIndex].sprite = sprite
            self.simulator.spots[spotIndex].isLocked = true
        }

        for _ in 0..<level {
            placeRandomSprite()
        }

        if simulator.potentialTorque == 0 {
            // Must add an equilibrium breaker
            placeRandomSprite()
        }

        // Choose place where user must place the sprite to balance the tabla
        var answerSpot: Int
        if simulator.potentialTorque > 0 {
            // Must be one of the left
            answerSpot = (availableSpots.filter { $0 <= 7 }).randomElement()!
        } else {
            answerSpot = (availableSpots.filter { $0 > 7 }).randomElement()!
        }
        
        // Calculate the necessary weight that the sprite must have to balance tabla in that spot
        let spriteWeight = abs(simulator.potentialTorque) / simulator.spots[answerSpot].distance
        
        // Now calculate random sprite to place
        switch spriteWeight {
        case 0..<20:
            simulator.selectedSprite = SpriteFactory.getRandomUnusedSpriteForWeightCategory(availableSprites: availableSprites, weightCategory: .lightweight)
        case 20..<60:
            simulator.selectedSprite = SpriteFactory.getRandomUnusedSpriteForWeightCategory(availableSprites: availableSprites, weightCategory: .middleweight)
        default:
            simulator.selectedSprite = SpriteFactory.getRandomUnusedSpriteForWeightCategory(availableSprites: availableSprites, weightCategory: .heavyweight)
        }

        simulator.selectedSprite!.weight = spriteWeight
        
        // Now choose whose sprite's weight the user must find
        let unknownWeightSpriteIndex = usedSpots.randomElement()!
        
        simulator.spots[unknownWeightSpriteIndex].showWeight = false
        
        self.questionSprite = simulator.spots[unknownWeightSpriteIndex].sprite

        simulator.columnsEnabled = false // Start simulation
        
        print("---Mass Estimation Question---")
        print("Lugar Incógnita: \(unknownWeightSpriteIndex), Sprite: \(simulator.spots[unknownWeightSpriteIndex].sprite!.name), Weight: \(simulator.spots[unknownWeightSpriteIndex].sprite!.weight)")
    }
}
