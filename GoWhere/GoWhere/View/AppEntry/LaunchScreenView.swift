//
//  LaunchScreenView.swift
//  GoWhere
//
//  Created by Hang Vu on 30/9/2024.


import SwiftUI

//LAUNCH SCREEN VIEW Struct
struct LaunchScreenView: View {
    
    //STATE variable to track whether the view is active
    @State private var isActive = false
    //STATE variable to manage the size of the view
    @State private var size = 0.8
    //STATE variable to control the opacity of the view
    @State private var opacity = 0.5
    
    //  APP ViewModel
    //  @ObservedObject private var viewModel: ?ViewModel = ?ViewModel()
    
    //LAUNCH SCREEN VIEW
    var body: some View {
        ZStack {
            BGM_Color
            //Navigates to the APP ENTRY VIEW after the LAUNCH SCREEN
            if isActive {
                ContentView()
                    .background(.white)
            } else {
                VStack {
                    appLogo
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            //Providing APP LOGO ANIMATION 0 DURATION 1.2
                            withAnimation(.easeIn(duration: 1.2)) {
                                self.size = 0.9
                                self.opacity = 1.0
                            }
                        }
                }
                .onAppear {
                    //ANIMATION to the next view
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
        .onAppear(perform: {
            ContentView()
        })
    }
    
    
    //APP LOGO Appearance
    var appLogo: some View {
        VStack {
            Image(.logo)
                .resizable()
                .frame(width: 350, height: 350)
                .padding()
                .shadow(color: Color(hex: 0xe5e5ea, alpha: 0.22), radius: 34, x: 0, y: -16)
                .shadow(color: Color(hex: 0xd1d1d6, alpha: 0.25), radius: 24, x: 0, y: 2)
                .offset(x: -10, y: -80)
            
            Text("GoWhere")
                .padding(.top, 20)
                .font(.custom("SFProRounded-Medium", size: 28))
                .foregroundStyle(.white)
                .tracking(5.0)
                .frame(height: 32, alignment: .center)
                .opacity(0.85)
                .multilineTextAlignment(.center)
        }
    }
    
    //  MARK: - BACKGROUND COLOR THEME
    var BGM_Color: some View {
        ZStack{}
            .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .topLeading)
            .background(LinearGradient(gradient:
                                        Gradient(stops: [
                                            .init(color: Color(hex: 0x1B5E20), location: CGFloat(0)),  // Dark green
                                            .init(color: Color(hex: 0x2E7D32), location: CGFloat(0.518310546875)),  // Slightly lighter dark green
                                            .init(color: Color(hex: 0x388E3C), location: CGFloat(1))  // Medium dark green
                                        ])
                                       , startPoint: UnitPoint(x: 0, y: 0.49999999999999994), endPoint: UnitPoint(x: 1, y: 0.5))
                .ignoresSafeArea())
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
    }
}

#Preview {
    LaunchScreenView()
}

