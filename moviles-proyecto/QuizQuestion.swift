//
//  QuizQuestion.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

protocol QuizQuestion {
    var level: Int { get set }
    var simulator: Simulator { get set }
    var answerStatus: AnswerStatus { get set }
    
    init(level: Int)
    mutating func checkAnswer()
    mutating func generateQuestion()
}
