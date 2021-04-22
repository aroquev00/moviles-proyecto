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
    
    init(level: Int, points: Int, questions: [QuizQuestion]) {
        self.level = level
        self.points = points
        self.questions = questions
    }
}
