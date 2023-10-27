////
////  LaunchScreenView.swift
////  Instinct
////
////  Created by Christian Rodriguez on 10/24/23.
////
//import SwiftUI
//
//struct LaunchScreenView: View {
//    var title : String
//    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager // Mark 1
//    
//    
//    @ViewBuilder
//    private var image: some View {
//        // Mark 3
//        GIFView(type: .name("launchScreen"))
//        
//        
//        //        Image("world_icon")
//        //            .resizable()
//        //            .scaledToFit()
//        //            .frame(width: 120, height: 120)
//        //            .rotationEffect(firstAnimation ? Angle(degrees: 900) : Angle(degrees: 1800)) // Mark 4
//        //            .scaleEffect(secondAnimation ? 0 : 1) // Mark 4
//        //            .offset(y: secondAnimation ? 400 : 0) // Mark 4
//    }
//    
//    
//    var body: some View {
//        ZStack {
//            // Mark 3
//            image  // Mark 3
//        }
//        
//        
//    }
//}
//
//struct LaunchScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        LaunchScreenView(title: "waht")
//            .environmentObject(LaunchScreenStateManager())
//    }
//}
