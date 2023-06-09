//
//  StartButton.swift
//  LEDBoardExternalDisplay
//
//  Created by cmStudent on 2023/06/12.
//

import SwiftUI

struct StartButton: View {
    
    var action: () -> ()
    @Binding var status: Bool
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(status ? DisplayConnectionStatus.connected.buttonText : DisplayConnectionStatus.disconnected.buttonText)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .minimumScaleFactor(0.5)
                Spacer()
            }
        }
        .padding()
        .background(Color.yellow)
        .cornerRadius(8)
        .shadow(color: .yellow, radius: 8)
        .padding()
        .padding(.top)
    }
}

struct StartButton_Previews: PreviewProvider {
    static var previews: some View {
        StartButton(action: { print("start button") }, status: .constant(true))
    }
}
