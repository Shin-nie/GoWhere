//
//  TabButton.swift
//  GoWhere
//
//  Created by Hang Vu on 25/9/2024.
//

import SwiftUI

struct TabButton: View {
    
    //  MARK: - PROPERTIES
    var title: String
    var image: String
    @Binding var isSelected: String
    
    //  MARK: - BODY
    //  represent how each tab button looks like along with the animations
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {isSelected = title}
        } ){
            icons
        }
    }
    
    //  MARK: - Sub-View
    //The appearance of icons for each tab Button
    var icons: some View {
        HStack(spacing: 10){
            Image(systemName: image)
                .resizable()
                .renderingMode(.template)
                .frame(width: 20, height: 20)
                .foregroundStyle(.black.gradient)
            if isSelected == title {
                Text(title)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(Color(.systemPink).gradient.opacity(isSelected == title ? 0.8 : 0))
        //Color(.systemRed).gradient.opacity(0.8)
        //Color(.systemGreen).opacity
        .clipShape(Capsule())
    }
}

//  MARK: - PREVIEWS
#Preview {
    TabButton(title: "Test", image: "suit.heart.fill", isSelected: .constant(""))
}
