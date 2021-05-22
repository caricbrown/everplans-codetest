//
//  ButtonPrimaryStyle.swift
//  CodeTest
//
//  Created by Aric Brown on 5/16/21.
//

import SwiftUI

//struct ButtomCustomStyle: ButtonStyle {
//    func makeBody(configuration: Self.Configuration) -> some View {
//        configuration.label
//            .foregroundColor(Color.white)
//            .font(.system(size: 16, weight: .semibold))
//            .padding()
//            .background(Color.greenColor)
//            .cornerRadius(32.0)
//            .padding(.vertical, 10)
//            .padding(.horizontal, 24)
//    }
//}

struct ButtonPrimaryStyle: ButtonStyle {
    struct Content: View {
        @Environment(\.isEnabled) var isEnabled
        let configuration: Configuration
        
        var body: some View {
            VStack {
                if !isEnabled {
                    configuration.label
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(32.0)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 24)
                } else if configuration.isPressed {
                    configuration.label
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(32.0)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 24)
                } else {
                    configuration.label
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                        .padding()
                        .background(Color.greenColor)
                        .cornerRadius(32.0)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 24)
                }
            }
        }
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        Content(configuration: configuration)
    }
}
