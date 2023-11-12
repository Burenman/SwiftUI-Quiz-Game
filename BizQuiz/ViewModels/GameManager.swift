//
//  GameManager.swift
//  BizQuiz
//
//  Created by Viktor on 2023-11-11.
//

import Foundation
import SwiftUI

class GameManagerVM : ObservableObject {

    static var currentIndex = 0
    
    static func createGameModel(i:Int) -> Quiz {
        return Quiz(currentQuestionIndex: i, quizModel: quizData[i])
    }
    
    @Published var model = GameManagerVM.createGameModel(i: GameManagerVM.currentIndex)
    
    
    var timer = Timer()
    var maxProgress = 60
    @Published var progress = 0
    
    init() {
        self.start()
    }
    
    func verifyAnswer(selectedOption: QuizOption) {
        for index in model.quizModel.optionsList.indices {
            model.quizModel.optionsList[index].isMatched = false
            model.quizModel.optionsList[index].isSelected = false
            
        }
        if let index = model.quizModel.optionsList.firstIndex(where: {$0.optionId == selectedOption.optionId}) {
            if selectedOption.optionId ==  model.quizModel.answer {
                model.quizModel.optionsList[index].isMatched = true
                model.quizModel.optionsList[index].isSelected = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if (GameManagerVM.currentIndex < 9) {
                        GameManagerVM.currentIndex = GameManagerVM.currentIndex + 1
                        self.model = GameManagerVM.createGameModel(i: GameManagerVM.currentIndex)
                    } else {
                        self.model.quizCompleted = true
                        self.model.quizWinningStatus = true
                        self.reset()
                    }
                }
            } else {
                model.quizModel.optionsList[index].isMatched = false
                model.quizModel.optionsList[index].isSelected = true
            }

        }
    }
    
    func restartGame() {
        GameManagerVM.currentIndex = 0
        model = GameManagerVM.createGameModel(i: GameManagerVM.currentIndex)
        self.start()
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { time in
            if self.progress == self.maxProgress {
                self.model.quizCompleted = true
                self.model.quizWinningStatus = false
                self.reset()
            } else {
                self.progress += 1
            }
        }
    }

    func reset() {
        timer.invalidate()
        self.progress = 0
    }

    func resetTimer() {
        self.progress = 0
    }

    func addTime() {
        // Increase timer by 3 seconds for a wrong answer, but not exceeding the maximum time
        self.progress += 3
        if self.progress > self.maxProgress {
            self.progress = self.maxProgress
        }
    }
}
                                


extension GameManagerVM
{
    static var quizData: [QuizModel] {
        [
            QuizModel(question: "Which planet is known as the 'Red Planet'?",
                      answer: "B",
                      optionsList: [QuizOption(id: 11, optionId: "A", option: "Earth", color: Color.yellow),
                                    QuizOption(id: 12,optionId: "B", option: "Mars", color: Color.red),
                                    QuizOption(id: 13,optionId: "C", option: "Jupiter", color: Color.green),
                                    QuizOption(id: 14,optionId: "D", option: "Venus", color: Color.purple)]),
            
            QuizModel(question: "What is the largest planet in our solar system?",
                      answer: "C",
                      optionsList: [QuizOption(id: 21,optionId: "A", option: "Mars", color: Color.yellow),
                                    QuizOption(id: 22,optionId: "B", option: "Earth", color: Color.red),
                                    QuizOption(id: 23,optionId: "C", option: "Jupiter", color: Color.green),
                                    QuizOption(id: 24,optionId: "D", option: "Saturn", color: Color.purple)]),
            
            QuizModel(question: "Which planet is closest to the Sun?",
                      answer: "A",
                      optionsList: [QuizOption(id: 31,optionId: "A", option: "Mercury", color: Color.yellow),
                                    QuizOption(id: 32,optionId: "B", option: "Venus", color: Color.red),
                                    QuizOption(id: 33,optionId: "C", option: "Mars", color: Color.green),
                                    QuizOption(id: 34,optionId: "D", option: "Jupiter", color: Color.purple)]),
            
            QuizModel(question: "What is the name of the largest moon of Jupiter?",
                      answer: "D",
                      optionsList: [QuizOption(id: 41,optionId: "A", option: "Europa", color: Color.yellow),
                                    QuizOption(id: 42,optionId: "B", option: "Titan", color: Color.red),
                                    QuizOption(id: 43,optionId: "C", option: "Ganymede", color: Color.green),
                                    QuizOption(id: 44,optionId: "D", option: "Callisto", color: Color.purple)]),
            
            QuizModel(question: "Which planet is known as the 'Blue Planet'?",
                      answer: "C",
                      optionsList: [QuizOption(id: 51,optionId: "A", option: "Mars", color: Color.yellow),
                                    QuizOption(id: 52,optionId: "B", option: "Saturn", color: Color.red),
                                    QuizOption(id: 53,optionId: "C", option: "Earth", color: Color.green),
                                    QuizOption(id: 54,optionId: "D", option: "Uranus", color: Color.purple)]),
            
            QuizModel(question: "What is the name of the famous telescope in space launched by NASA?",
                      answer: "B",
                      optionsList: [QuizOption(id: 61,optionId: "A", option: "Hubble", color: Color.yellow),
                                    QuizOption(id: 62,optionId: "B", option: "James Webb", color: Color.red),
                                    QuizOption(id: 63,optionId: "C", option: "Galileo", color: Color.green),
                                    QuizOption(id: 64,optionId: "D", option: "Kepler", color: Color.purple)]),
            
            QuizModel(question: "How many planets are there in our solar system?",
                      answer: "D",
                      optionsList: [QuizOption(id: 71,optionId: "A", option: "12", color: Color.yellow),
                                    QuizOption(id: 72,optionId: "B", option: "9", color: Color.red),
                                    QuizOption(id: 73,optionId: "C", option: "10", color: Color.green),
                                    QuizOption(id: 74,optionId: "D", option: "8", color: Color.purple)]),
            
            QuizModel(question: "Which planet is known as the 'Ringed Planet'?",
                      answer: "C",
                      optionsList: [QuizOption(id: 81,optionId: "A", option: "Mars", color: Color.yellow),
                                    QuizOption(id: 82,optionId: "B", option: "Jupiter", color: Color.red),
                                    QuizOption(id: 83,optionId: "C", option: "Saturn", color: Color.green),
                                    QuizOption(id: 84,optionId: "D", option: "Uranus", color: Color.purple)]),
            
            QuizModel(question: "What is the name of the first artificial satellite launched into space?",
                      answer: "A",
                      optionsList: [QuizOption(id: 91,optionId: "A", option: "Sputnik 1", color: Color.yellow),
                                    QuizOption(id: 92,optionId: "B", option: "Explorer 1", color: Color.red),
                                    QuizOption(id: 93,optionId: "C", option: "Vanguard 1", color: Color.green),
                                    QuizOption(id: 94,optionId: "D", option: "Telstar 1", color: Color.purple)]),
            
            QuizModel(question: "What is the name of the dwarf planet in our solar system?",
                      answer: "B",
                      optionsList: [QuizOption(id: 101,optionId: "A", option: "Pluto", color: Color.yellow),
                                    QuizOption(id: 102,optionId: "B", option: "Eris", color: Color.red),
                                    QuizOption(id: 103,optionId: "C", option: "Haumea", color: Color.green),
                                    QuizOption(id: 104,optionId: "D", option: "Ceres", color: Color.purple)])
        ]
    }

}
