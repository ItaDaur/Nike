//
//  LaunchScreen.swift
//  Nike
//
//  Created by Dauren Sarsenov on 10.01.2023.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        
        if isActive {
            ContentView()
        }
        else {
            VStack {
                VStack {
                    Image("NikeIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 190.0, height: 368.0)
                    
                    Text("Nike Shop")
                        .font(.custom("", size: 50))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
