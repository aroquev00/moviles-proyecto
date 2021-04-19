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
    var selectedAnswer: String
    
    init(level: Int) {
        self.level = level
        simulator = Simulator()
        answerStatus = .unanswered
        selectedAnswer = ""
        
    }
    
    func checkAnswer() {
    }
}
