//
//  ContentView.swift
//  Memorize
//
//  Created by Rojin Prajapati on 10/13/23.
//

import SwiftUI

struct ContentView: View {
    
    let sports: Array<String> = ["⚽️", "🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏑","🏏", "🥊", "🏄🏻‍♂️","🏊🏼‍♀️"]
    let halloween: Array<String> = ["😈", "👹", "👻", "☠️", "👽","🎃", "👺","🤡", "🤖","💀"]
    let food: Array<String> = ["🍔", "🍟", "🍕", "🌮", "🍪", "🍿", "🍎", "🍌", "🍫", "🥟", "🍳", "🍜"]
    
    var themeCollection: [[String]] {
        [sports] +  [food] + [halloween]
    }
    
    @State var selectedTheme: [String] =  []
    @State var themeColor: Color = Color.gray
    
    @State var cardCounter: Int = 3
    var body: some View {
        
        VStack{
            
            Text("Memorize!").font(.largeTitle)
            ScrollView{
                cards(theme: selectedTheme, color: themeColor)
            }
            Spacer()
            addTheme
            Spacer()
            cardAddRemove(theme: selectedTheme)
        }.padding()
    }
    
    var themePicker: some View {
        HStack {
            
        }
    }
    
    func themeButton(themeName: String, theme: [String], themeColor: Color, symbol: String) -> some View {
            Button(action: {
                selectedTheme = theme.shuffled()
                self.themeColor = themeColor
            }){
                VStack {
                    Image(systemName: symbol).font(.largeTitle).imageScale(.large)
                    Text(themeName)
                }
            }
    }
    
    var addTheme: some View {
        HStack{
            themeButton(themeName: "sports", theme: sports, themeColor: Color.red, symbol: "figure.run.circle.fill")
            themeButton(themeName: "food", theme: food, themeColor: Color.yellow, symbol: "fork.knife.circle.fill")
            themeButton(themeName: "halloween", theme: halloween, themeColor: Color.purple, symbol: "theatermasks.circle.fill")
        }
    }
    
    func cards(theme: [String], color: Color) -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
            ForEach(0..<theme.count, id: \.self){ index in
                CardView(symbol: theme[index], color: color)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
    }
    
    func cardAddRemove(theme: [String])-> some View {
        HStack{
            cardCountAdjuster(by: 1, symbol: "rectangle.stack.fill.badge.plus", theme: theme)
            Spacer()
            cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill", theme: theme)
        }
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String, theme: [String])-> some View{
        Button(action: { cardCounter += offset }) {
            Image(systemName: symbol)
                .imageScale(.large)
        }.disabled(cardCounter + offset < 0 || cardCounter + offset > theme.count)
    }
    
}

//struct themeView: View {
//    
//    
//    var body: some View {
//        // title
//        // card list of selected theme
//        // lists of theme button
//        // card add/remove button
//        VStack{
//            Text("Memorize!").font(.largeTitle)
//            ScrollView{
//                cards(theme: food)
//            }
//            Spacer()
//            addTheme
//            Spacer()
//            cardAddRemove(theme: food)
//        }.padding()
//    }
//        
//}
    

// create a card view for a memorize game so you can reuse it every time to create a new card
struct CardView: View {
    let symbol: String
    let color: Color
    @State var isFaceUp: Bool = false
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 18)
            Group {
                base.strokeBorder(color, lineWidth: 2.0)
                Text(symbol).padding()
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill(color).opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}



#Preview {
    ContentView()
}
