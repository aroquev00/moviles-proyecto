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
    
    init(level: Int) {
        self.level = level
        simulator = Simulator()
        answerStatus = .unanswered
    }
    
    func checkAnswer() {
    }
    
    mutating func generateQuestion() {
        
    }
}
