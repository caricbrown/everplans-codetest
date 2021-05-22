//
//  TextFieldCustomStyle.swift
//  CodeTest
//
//  Created by Aric Brown on 5/16/21.
//

import SwiftUI

struct TextFieldCustomStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .cornerRadius(8)
            .font(.system(size: 16, weight: .regular))
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).fill(Color("backgroundColor")))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("borderColor")))
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
    }
}
