//
//  Quiz.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

struct Quiz {
    var level: Int
    var points: Int
    var questions: [QuizQuestion]
    var currentQuestion: Int
    
    init(level: Int) {
        self.level = level
        self.points = 0
        self.questions = []
        self.currentQuestion = 0
        
        
        generateQuestion()
    }
    
    mutating func nextQuestion() {
        if currentQuestion + 1 < questions.count {
            currentQuestion += 1
        }
    }
    
    mutating func previousQuestion() {
        if currentQuestion - 1 >= 0 {
            currentQuestion -= 1
        }
    }
    
    mutating func generateQuestion() {
        questions.append(PredictionQuestion(simulator: Simulator()))
        questions.append(MassEstimationQuestion(simulator: Simulator()))
        questions.append(PlacingQuestion(simulator: Simulator()))
    }
}
