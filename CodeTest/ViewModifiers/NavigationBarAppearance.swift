//
//  NavigationBarAppearance.swift
//  CodeTest
//
//  Created by Aric Brown on 5/18/21.
//

import SwiftUI
import UIKit

struct NavigationBarAppearance: ViewModifier {
    
    init(backgroundColor: Color, tintColor: Color) {
        let backgroundColor = UIColor(backgroundColor)
        let tintColor = UIColor(tintColor)
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.configureWithOpaqueBackground()
        barAppearance.backgroundColor = backgroundColor
        barAppearance.shadowImage = nil // line
        barAppearance.shadowColor = .none // line
        
        UINavigationBar.appearance().standardAppearance = barAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = barAppearance
        UINavigationBar.appearance().compactAppearance = barAppearance
        UINavigationBar.appearance().tintColor = tintColor
    }
    
    func body(content: Content) -> some View {
        content
    }
}
