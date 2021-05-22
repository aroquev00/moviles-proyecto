//
//  PlacingQuestion.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

struct PlacingQuestion: QuizQuestion {
    var level: Int
    var simulator: Simulator
    var answerStatus: AnswerStatus
    var questionType: QuizQuestionType
    var answerSpotIndex: Int
    
    init(level: Int) {
        self.level = level
        simulator = Simulator(quizMode: true)
        answerStatus = .unanswered
        questionType = .placing
        answerSpotIndex = -1 // Placeholder value
        
        generateQuestion()
    }
    
    mutating func checkAnswer() {
        print("Checking question")
        if simulator.potentialTorque == 0.0 {
            answerStatus = .correct
            print("correcto")
        } else {
            answerStatus = .incorrect
            print("incorrecto")
        }
    }
    
    mutating func generateQuestion() {
        var availableSprites = SpriteFactory.all
        
        func placeRandomSprite() {
            let spotIndex = availableSpots.randomElement()!
            availableSpots.remove(spotIndex)
            
            var sprite = availableSprites.randomElement()!
            availableSprites.remove(sprite)
            sprite.weight = SpriteFactory.getRandomWeightForSprite(sprite: sprite)
            
            self.simulator.spots[spotIndex].sprite = sprite
            self.simulator.spots[spotIndex].isLocked = true
        }
        
        var availableSpots = Set(0...15)
        
        for _ in 0..<level {
            placeRandomSprite()
        }
        
        if simulator.potentialTorque == 0 {
            // Must add an equilibrium breaker
            placeRandomSprite()
        }
        
        
        // Choose place that will be correct answer
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
        
        print("---Placing Question---")
        print("Spot respuesta: ", answerSpotIndex)
        
    }
    
    mutating func solveQuestion() {
        simulator.spots[answerSpotIndex].sprite = simulator.selectedSprite
        simulator.columnsEnabled = false
    }
    
    func getAnswer() -> String {
        return "\(simulator.selectedSprite!.name) va \(simulator.spots[answerSpotIndex].distance) m. a la \(simulator.spots[answerSpotIndex].side == .left ? "izquierda" : "derecha")."
    }
}
