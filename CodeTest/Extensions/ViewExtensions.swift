//
//  ViewExtensions.swift
//  CodeTest
//
//  Created by Aric Brown on 5/17/21.
//

import SwiftUI

public extension View {
    func navigationBarColor(backgroundColor: Color, tintColor: Color) -> some View {
      self.modifier(NavigationBarAppearance(backgroundColor: backgroundColor, tintColor: tintColor))
    }
    
    func fillParent(alignment: Alignment = .center) -> some View {
        self
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: alignment
            )
    }
    
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(.black20Color)
            .padding(.horizontal, 24)
            .padding(.vertical, 10)
    }
}
