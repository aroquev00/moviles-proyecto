//
//  MassEstimationQuestion.swift
//  moviles-proyecto
//
//  Created by Armando Roque Rodriguez on 18/04/21.
//

struct MassEstimationQuestion: QuizQuestion {
    var level: Int
    var simulator: Simulator
    var answerStatus: AnswerStatus
    var questionSprite: Sprite?
    var answerWeight: Float
    
    init(level: Int) {
        self.level = level
        simulator = Simulator(quizMode: true)
        answerStatus = .unanswered
        answerWeight = 0 // Placeholder value
        generateQuestion()
    }
    
    mutating func checkAnswer() {
        if answerWeight == questionSprite?.weight {
            answerStatus = .correct
            print("correcto")
        } else {
            answerStatus = .incorrect
            print("incorrecto")
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

        let heavySprites = [
            Sprite(name: "Master Chief", weight: 80, height: 1, imageURL: "masterchief"),
            Sprite(name: "Link", weight: 60, height: 1, imageURL: "link"),
        ]

        let mediumSprites = [
            Sprite(name: "Mario", weight: 20, height: 1, imageURL: "mario"),
            Sprite(name: "Megaman", weight: 20, height: 1, imageURL: "megaman"),
            Sprite(name: "Steve", weight: 30, height: 1, imageURL: "steve"),
        ]

        let lightSprites = [
            Sprite(name: "Plankton", weight: 0, height: 1, imageURL: "plankton"),
            Sprite(name: "Kirby", weight: 10, height: 1, imageURL: "kirby"),
            Sprite(name: "Sonic", weight: 15, height: 1, imageURL: "sonic"),
        ]
        
        func placeRandomSprite() {
            let spotIndex = availableSpots.randomElement()!
            availableSpots.remove(spotIndex)
            usedSpots.insert(spotIndex)
            
            self.simulator.spots[spotIndex].sprite = spritesRow[Int.random(in: 0..<(spritesRow.count))]
        }

        var availableSpots = Set(0...15)
        var usedSpots: Set<Int> = Set()

        for _ in 0..<level {
            placeRandomSprite()
        }

        if simulator.potentialTorque == 0 {
            // Must add an equilibrium breaker
            placeRandomSprite()
        }


        // Choose place where user must place the sprite to balance the tabla
        var answerSpot: Int
        if simulator.potentialTorque > 0 {
            // Must be one of the left
            answerSpot = (availableSpots.filter { $0 <= 7 }).randomElement()!
        } else {
            answerSpot = (availableSpots.filter { $0 > 7 }).randomElement()!
        }

        // Calculate the necessary weight that the sprite must have to balance tabla in that spot
        let spriteWeight = abs(simulator.potentialTorque) / simulator.spots[answerSpot].distance

        // Now calculate random sprite to place
        switch spriteWeight {
        case 0..<20:
            simulator.selectedSprite = lightSprites.randomElement()
        case 20..<60:
            simulator.selectedSprite = mediumSprites.randomElement()
        default:
            simulator.selectedSprite = heavySprites.randomElement()
        }

        simulator.selectedSprite!.weight = spriteWeight
        
        // Now choose whose sprite's weight the user must find
        let unknownWeightSpriteIndex = usedSpots.randomElement()!
        
        simulator.spots[unknownWeightSpriteIndex].showWeight = false
        
        self.questionSprite = simulator.spots[unknownWeightSpriteIndex].sprite

        simulator.columnsEnabled = false // Start simulation
        
        print("---Mass Estimation Question---")
        print("Lugar Incógnita: \(unknownWeightSpriteIndex), Sprite: \(simulator.spots[unknownWeightSpriteIndex].sprite!.name), Weight: \(simulator.spots[unknownWeightSpriteIndex].sprite!.weight)")
    }
}
