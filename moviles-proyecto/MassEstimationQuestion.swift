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
    var questionType: QuizQuestionType
    var questionSprite: Sprite?
    var answerWeight: Float
    var answerSpotIndex: Int
    var unknownWeightSpotIndex: Int
    
    init(level: Int) {
        self.level = level
        simulator = Simulator(quizMode: true)
        answerStatus = .unanswered
        questionType = .massEstimation
        answerWeight = 0 // Placeholder value
        answerSpotIndex = -1 // Placeholder value
        unknownWeightSpotIndex = -1 // Placeholder value
        
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
        //var answerSpotIndex: Int
        if simulator.potentialTorque > 0 {
            // Must be one of the left
            answerSpotIndex = (availableSpots.filter { $0 <= 7 }).randomElement()!
        } else {
            answerSpotIndex = (availableSpots.filter { $0 > 7 }).randomElement()!
        }
        
        // Calculate the necessary weight that the sprite must have to balance tabla in that spot
        let spriteWeight = abs(simulator.potentialTorque) / simulator.spots[answerSpotIndex].distance
        
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
        unknownWeightSpotIndex = usedSpots.randomElement()!
        
        simulator.spots[unknownWeightSpotIndex].showWeight = false
        
        self.questionSprite = simulator.spots[unknownWeightSpotIndex].sprite

        simulator.columnsEnabled = false // Start simulation
        
        print("---Mass Estimation Question---")
        print("Lugar Incógnita: \(unknownWeightSpotIndex), Sprite: \(simulator.spots[unknownWeightSpotIndex].sprite!.name), Weight: \(simulator.spots[unknownWeightSpotIndex].sprite!.weight)")
    }
    
    mutating func solveQuestion() {
        for (index, _) in simulator.spots.enumerated() {
            if !simulator.spots[index].isLocked {
                simulator.spots[index].sprite = nil
            }
        }
        simulator.spots[unknownWeightSpotIndex].showWeight = true
        simulator.spots[answerSpotIndex].sprite = simulator.selectedSprite
    }
    
    func getAnswer() -> String {
        return "\(questionSprite!.name) pesa \(questionSprite!.weight) kg."
    }
}
