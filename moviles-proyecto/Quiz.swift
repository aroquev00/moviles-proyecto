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
        
        generateQuestions()
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
    
    mutating func generateQuestions() {
        questions.append(PredictionQuestion(level: self.level))
        questions.append(PredictionQuestion(level: self.level))
        questions.append(MassEstimationQuestion(level: self.level))
        questions.append(MassEstimationQuestion(level: self.level))
        questions.append(PlacingQuestion(level: self.level))
        questions.append(PlacingQuestion(level: self.level))
        
        questions.shuffle()
    }
}
