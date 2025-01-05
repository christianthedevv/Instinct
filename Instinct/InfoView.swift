//
//  InfoView.swift
//  Instinct
//
//  Created by Christian Rodriguez on 1/4/25.
//

import SwiftUI

struct InfoView: View {
    @AppStorage(PlayerConfigKeys.saturation) private var saturation: Double = 1.0
    @AppStorage(PlayerConfigKeys.soundEffects) private var soundEffects: Bool = true
    @AppStorage(PlayerConfigKeys.level) private var level: Int = 3
    @AppStorage(PlayerConfigKeys.haptics) private var haptics: Bool = true
    
    var body: some View {
        VStack(alignment:.center){
            Text("HOW TO PLAY")
                .font(.custom("Tiny5-Regular", size: 55)).foregroundStyle(.black)
                .shadow(color:.gray ,radius: 0.2, x: -1, y: -1)
            Text("Trust your instincts and sort randomly generated colors.")
                .font(.custom("Tiny5-Regular", size: 30)).foregroundStyle(.red)
                .shadow(color:.black ,radius: 0.2, x: -1, y: -1)
                .multilineTextAlignment(.center)
            VStack(alignment:.leading, spacing:12){
                Text("1. One random color block is generated.")
                    .foregroundStyle(.white)
                    .shadow(color:.black ,radius: 0.2, x: -1, y: -1)
                Text("2. Place the generated block into one of the available slots")
                    .foregroundStyle(.white)
                    .shadow(color:.black ,radius: 0.2, x: -1, y: -1)
                Text("3. Successfully sort all colors into a rainbow sequence to win!")
                    .foregroundStyle(.white)
                    .shadow(color:.black ,radius: 0.2, x: -1, y: -1)
            }.padding().background(.gray).cornerRadius(10)
            HStack{
                VStack(alignment:.leading){
                    Text("CLASSIC")
                        .font(.custom("Tiny5-Regular", size: 40)).foregroundStyle(.black)
                        .shadow(color:.gray ,radius: 0.2, x: -1, y: -1)
                    Text("Organize 10 random colors into a rainbow sequence")
                        .foregroundStyle(.gray)
                        .shadow(color:.black ,radius: 0.2, x: -1, y: -1).padding(.bottom)
                    Text("ARCADE")
                        .font(.custom("Tiny5-Regular", size: 40)).foregroundStyle(.black)
                        .shadow(color:.gray ,radius: 0.2, x: -1, y: -1)
                    Text("Starting from just 3 colors, each round increases by one.")
                        .foregroundStyle(.gray)
                        .shadow(color:.black ,radius: 0.2, x: -1, y: -1)
                }
                
                VStack(spacing:0){
                    ForEach([0.0, 0.1, 0.15 ,0.2, 0.25, 0.3, 0.4, 0.5, 0.6,0.8], id:\.self){ i in
                        Rectangle()
                            .foregroundStyle(Color(hue: i, saturation: saturation, brightness: 1))
                            .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.width * 0.05)

                            .shadow(color: Color(hue: i, saturation: saturation, brightness: 0.5), radius: 1, x: -3, y: 0)
                    }
                }
                .padding(.leading, 3)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .frame(width: UIScreen.main.bounds.width * 0.1)
            }
            Spacer()
        }.padding()
    }
}

#Preview {
    InfoView()
}
