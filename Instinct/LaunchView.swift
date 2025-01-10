//
//  LaunchView.swift
//  Instinct
//
//  Created by Christian Rodriguez on 1/1/25.
//

import SwiftUI

struct LaunchView: View {
    @Binding var launched : Bool
    
    @State var spelled: [launchBlock] = []
    @State var goal: [launchBlock]
    @State private var animationStep: Int = 0
    @State private var timer: Timer?
    @State var hideColors: Bool = false
    @State var shift: Bool = false
    @Namespace private var launchAnimation
    @Namespace private var blocks



    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea()
            if !launched{
                    if !shift{
                        VStack(alignment:.center,spacing: 0) {
                            
                            ForEach(spelled, id: \.id) { letter in
                                LaunchBlock(letter: letter)
                            }
                        }
                        
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                    }else{
                        VStack{
                            HStack() {
                                ForEach(spelled, id: \.id) { letter in
                                    LaunchBlock(letter: letter)
                                }
                            }
                            Spacer()
                        }.padding(.top, 100)

                    }
            }else{
                VStack{
                    HStack() {
                        ForEach(goal, id: \.id) { letter in
                            LaunchBlock(letter: letter)
                        }
                    }
                    Spacer()
                }.padding(.top, 100)
            }
            
        }
        .background(Color.background)
        .onAppear {
            if !launched{
                timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
                    if animationStep < goal.count {
                        spelled.append(goal[animationStep]) // Append the current step from goal
                        animationStep += 1
                    } else {
                        timer?.invalidate() // Stop the timer when spelled matches goal
                        withAnimation(.smooth){
                            hideColors = true
                            
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.bouncy){
                                shift = true
                                launched = true
                            }
                        }

                    }
                }
            }else{
                withAnimation(.smooth){
                    hideColors = true
                    
                }
            }
        }
        .onDisappear {
            timer?.invalidate() // Clean up the timer when the view disappears
        }
    }
    
    @ViewBuilder
    func LaunchBlock(letter:launchBlock) -> some View {
        ZStack{
            if !hideColors{
                Group{
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.width * 0.2)
                        .foregroundStyle(letter.color.gradient)
                    Color.black.opacity(0.2)
                        .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.width * 0.2)
                }.transition(.opacity)
            }

            Text(letter.letter)
                    .font(.custom("Tiny5-Regular", size:42))
                    .foregroundStyle(!shift ? .white : hideColors ? .text : .inverseText)
                    .shadow(color: !shift ? .black : hideColors ? .inverseText : .text, radius:1, x: -1, y: -1)

                    
        }.matchedGeometryEffect(id: letter.id.uuidString, in: launchAnimation)
    }
}



struct launchBlock {
    var id: UUID = UUID()
    var letter: String
    var color: Color
}

#Preview {
    LaunchView(launched: .constant(false), goal: [.init(letter: "i", color: Color(hue: 0, saturation: 1, brightness: 1)), .init(letter: "N", color: Color(hue: 0.1, saturation: 1, brightness: 1)), .init(letter: "S", color: Color(hue: 0.15, saturation: 1, brightness: 1)), .init(letter: "T", color: Color(hue: 0.2, saturation: 1, brightness: 1)), .init(letter: "i", color: Color(hue: 0.3, saturation: 1, brightness: 1)), .init(letter: "N", color: Color(hue: 0.5, saturation: 1, brightness: 1)), .init(letter: "C", color: Color(hue: 0.7, saturation: 1, brightness: 1)), .init(letter: "T", color: Color(hue: 0.8, saturation: 1, brightness: 1))])
}
