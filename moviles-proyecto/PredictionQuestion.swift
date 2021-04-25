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
        
    }
}
