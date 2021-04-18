//
//  PredictionQuestion.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

struct PredictionQuestion: QuizQuestion {
    var simulator: Simulator
    
    func checkAnswer() -> Bool {
        return true
    }
}
