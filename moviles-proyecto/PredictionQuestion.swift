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
        simulator = Simulator()
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
        let spritesRow = [
            Sprite(name: "Mario", weight: 20, height: 1, imageURL: "mario"),
            Sprite(name: "Kirby", weight: 10, height: 1, imageURL: "kirby"),
            Sprite(name: "Steve", weight: 30, height: 1, imageURL: "steve"),
            Sprite(name: "Master Chief", weight: 80, height: 1, imageURL: "masterchief"),
            Sprite(name: "Plankton", weight: 5, height: 1, imageURL: "plankton"),
            Sprite(name: "Sonic", weight: 15, height: 1, imageURL: "sonic"),
            Sprite(name: "Link", weight: 60, height: 1, imageURL: "link"),
            Sprite(name: "Megaman", weight: 20, height: 1, imageURL: "megaman")
        ]
        
        func placeSprite(range: ClosedRange<Int>) {
            var spotIndex: Int
            repeat {
                 spotIndex = Int.random(in: range)
            } while usedSpots.contains(spotIndex)
            
            usedSpots.insert(spotIndex)
            self.simulator.spots[spotIndex].sprite = spritesRow[Int.random(in: 0..<(spritesRow.count))]
        }
        
        var usedSpots = Set<Int>()
        for _ in 0..<level {
            placeSprite(range: 0...7) // Left side
            placeSprite(range: 8...15) // Right side
        }
    }
}
