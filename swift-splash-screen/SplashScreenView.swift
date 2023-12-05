//
//  SplashScreenView.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-13.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            SplashView()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation{
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashView: View {
    
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "film.stack")
                    .font(.system(size: 100))
                    .foregroundColor(.orange)
                Text("Awesome App")
                    .font(Font
                        .custom("Baskerville-Bold", size: 28))
                    .foregroundStyle(.orange.opacity(0.80))
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

    }
}

#Preview {
    SplashScreenView()
        .environmentObject(MediaViewModel())
}
