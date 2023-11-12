//
//  reusableText.swift
//  BizQuiz
//
//  Created by Viktor on 2023-11-11.
//

import SwiftUI

struct ReusableText: View {
    var text: String
    var size: CGFloat
    var body: some View {
        Text(text)
            .font(.system(size: size, weight: .bold, design: .rounded))
            .foregroundStyle(.white)
            .shadow(color: Color.black, radius: 5)
            .fixedSize(horizontal: false, vertical: true) 
    }
}

#Preview {
    ReusableText(text: "Hey Hello", size: 30)
}
