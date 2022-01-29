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
        VStack {
            gameBody
            shuffle
        }
        .padding()
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        return !dealt.contains(card.id)
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if isUndealt(card) || card.isMatched && !card.isFaceUp {
                Color.clear
            } else {
                CardView(card: card)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity).animation(.easeInOut(duration: 3)))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
            
        }
        .onAppear {
            // "deal" cards
            withAnimation {
                for card in game.cards {
                    deal(card)
                }
            }
        }
        
            .foregroundColor(.red)
    }
    var shuffle: some View {
        Button("Shuffle"){
            withAnimation {
                game.shuffle()
            }
        }

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
       return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {

                    Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 110 - 90))
                        .padding(5).opacity(0.5)
                    Text(card.content)
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstant.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cadify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstant.fontScale)
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height ) / (DrawingConstant.fontSize / DrawingConstant.fontScale)
    }
    
    private struct DrawingConstant {
        static let fontScale: CGFloat = 0.70
        static let fontSize: CGFloat = 32
    }
}
