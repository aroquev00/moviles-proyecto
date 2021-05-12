//
//  PredictionQuestion.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

struct PredictionQuestion: QuizQuestion {
    var level: Int
    var simulator: Simulator
    var answerStatus: AnswerStatus
    var selectedAnswer: Swivel?
    
    init(level: Int) {
        self.level = level
        simulator = Simulator(quizMode: true)
        answerStatus = .unanswered
        selectedAnswer = nil
        
        generateQuestion()
    }
    
    mutating func checkAnswer() {
        if simulator.potentialTorque > 0 {
            if selectedAnswer == Swivel.right {
                answerStatus = AnswerStatus.correct
            } else {
                answerStatus = AnswerStatus.incorrect
            }
        } else if simulator.potentialTorque < 0 {
            if selectedAnswer == Swivel.left {
                answerStatus = AnswerStatus.correct
            } else {
                answerStatus = AnswerStatus.incorrect
            }
        } else {
            if selectedAnswer == Swivel.equilibrium {
                answerStatus = AnswerStatus.correct
            } else {
                answerStatus = AnswerStatus.incorrect
            }
        }
    }
    
    mutating func generateQuestion() {
        simulator.rulerEnabled = true
        
        var availableSprites = SpriteFactory.all
        
        var leftAvailableSpots = Set(0...7)
        var rightAvailableSpots = Set(8...15)
        
        func placeRandomSprite(side: Side) {
            var spotIndex: Int
            if side == .left {
                spotIndex = leftAvailableSpots.randomElement()!
                leftAvailableSpots.remove(spotIndex)
            } else {
                spotIndex = rightAvailableSpots.randomElement()!
                rightAvailableSpots.remove(spotIndex)
            }
            
            var sprite = availableSprites.randomElement()!
            availableSprites.remove(sprite)
            sprite.weight = SpriteFactory.getRandomWeightForSprite(sprite: sprite)
            
            self.simulator.spots[spotIndex].sprite = sprite
            self.simulator.spots[spotIndex].isLocked = true
        }
        
        for _ in 0..<level {
            placeRandomSprite(side: .left) // Left side
            placeRandomSprite(side: .right) // Right side
        }
    }
}
