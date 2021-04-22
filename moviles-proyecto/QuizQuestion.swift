//
//  QuizQuestion.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

protocol QuizQuestion {
    var simulator: Simulator { get set }
    
    func checkAnswer() -> Bool
}
