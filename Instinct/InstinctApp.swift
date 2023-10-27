//
//  InstinctApp.swift
//  Instinct
//
//  Created by Christian Rodriguez on 10/23/23.
//

import SwiftUI

@main
struct InstinctApp: App {
    @State var launch = true

    var body: some Scene {
        WindowGroup {
            ZStack{
                ContentView()
                if launch {
                    Color.white.ignoresSafeArea()
                    
                    VStack(spacing: 10){
                        GIFView(type: .name("launchScreen")).frame(width: 500, height: 700).onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 9.0) {
                                withAnimation(.spring)  {
                                    self.launch = false
                                }
                            }
                        }

                        Text("tap to skip").font(.custom("Monda-Regular", size: 15)).foregroundStyle(.gray)
                    }.onTapGesture {
                        withAnimation(.spring) {
                            self.launch = false
                        }
                    }
                }
            }
        }
    }
}
