

//
//  OptionsGridView.swift
//  BizQuiz
//
//  Created by Viktor on 2023-11-11.
//

import Foundation
import SwiftUI


struct OptionsGridView: View {
    var gameManagerVM: GameManagerVM
    var columns: [GridItem] = Array(repeating: GridItem(.fixed(170), spacing: 0), count: 2)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(gameManagerVM.model.quizModel.optionsList) { quizOption in
                OptionCardView(quizOption: quizOption)
                    .onTapGesture {
                        gameManagerVM.verifyAnswer(selectedOption: quizOption)
                        provideHapticFeedback(for: quizOption.isMatched)
                    }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1)) // Add a background color
        .cornerRadius(20)
        .padding(10)
    }
    
    func provideHapticFeedback(for correctAnswer: Bool) {
        let generator: UINotificationFeedbackGenerator = {
            if #available(iOS 13.0, *) {
                return UINotificationFeedbackGenerator()
            } else {
                return UINotificationFeedbackGenerator()
            }
        }()

        generator.prepare()

        if correctAnswer {
            generator.notificationOccurred(.success)
        } else {
            generator.notificationOccurred(.error)
        }
    }
}



struct OptionCardView : View {
    var quizOption: QuizOption
    var body: some View {
        VStack {
            if (quizOption.isMatched) && (quizOption.isSelected) {
                OptionStatusImageView(imageName: "checkmark")
            } else if (!(quizOption.isMatched) && (quizOption.isSelected)) {
                OptionStatusImageView(imageName: "xmark")
            } else {
                OptionView(quizOption: quizOption)
            }
        }.frame(width: 150, height: 150)
            .background(setBackgroundColor())
            .cornerRadius(40)
    }
    
    func setBackgroundColor() -> Color {
        if (quizOption.isMatched) && (quizOption.isSelected) {
            return Color.green
        } else if (!(quizOption.isMatched) && (quizOption.isSelected)) {
            return Color.red
        } else {
            return Color.white
        }
    }
}

struct OptionView: View {
    var quizOption: QuizOption
    var body: some View {
        VStack{
            Text(quizOption.optionId)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .frame(width: 50, height: 50)
                .background(quizOption.color.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(25)
            
            Text(quizOption.option)
                .frame(width: 150, height: 38)
                .font(.system(size: 20, weight: .bold, design: .rounded))
        }
    }
}

struct OptionStatusImageView: View {
    var imageName: String
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(EdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40))
            .foregroundColor(Color.white)
    }
}
