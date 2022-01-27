//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Tony on 14/01/2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
   @ObservedObject var game: EmojiMemoryGame

    var body: some View {
      
//            ScrollView {
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
//                    ForEach(game.cards) { card in
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
            CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                .onTapGesture {
                    game.choose(card)
                }
        })
                        
//                    }
//                }
//
//            }
    .foregroundColor(.red)
    .padding(.horizontal)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstant.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: 3)
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape .fill()
                }
                
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstant.fontScale)
    }
    
    private struct DrawingConstant {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}
