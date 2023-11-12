//
//  BizQuizApp.swift
//  BizQuiz
//
//  Created by Viktor on 2023-11-11.
//

import SwiftUI

@main
struct BizQuizApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(gameManagerVM: GameManagerVM())
        }
    }
}
