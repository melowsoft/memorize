//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Tony on 14/01/2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
   private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
