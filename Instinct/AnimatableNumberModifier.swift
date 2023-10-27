//
//  AnimatableNumberModifier.swift
//  Instinct
//
//  Created by Christian Rodriguez on 10/23/23.
//

import Foundation
import SwiftUI

struct AnimatableNumberModifier: AnimatableModifier {
    var number: Double
    
    var animatableData: Double {
        get { number }
        set { number = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Text("\(Int(number))").font(.custom("Monda-Regular", size: 55)).foregroundStyle(.teal)
            )
    }
}

extension View {
    func animatingNumberOverlay(for number: Double) -> some View {
        modifier(AnimatableNumberModifier(number: number))
    }
}

struct AnimatableColorModifier: AnimatableModifier {
    var colorHue: Double
    var colorHues: [Double] = [0, 0.07, 0.1 , 0.133,
                               0.150, 0.165, 0.190,0.23,
                               0.33, 0.430, 0.465, 0.5,
                               0.53, 0.55, 0.6, 0.7,
                               0.74, 0.76, 0.8, 0.835, 0.9]
    
    var animatableData: Double {
        get { colorHue }
        set { colorHue = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                Color(hue: colorHues[Int(colorHue)], saturation: 1, brightness: 1)
            )
    }
}

extension View {
    func animatingColorBackground(for colorHue: Double) -> some View {
        modifier(AnimatableColorModifier(colorHue: colorHue))
    }
}
