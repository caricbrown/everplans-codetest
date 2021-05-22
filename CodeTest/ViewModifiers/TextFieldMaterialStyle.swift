//
//  TextFieldMaterialStyle.swift
//  CodeTest
//
//  Created by Aric Brown on 5/16/21.
//

import SwiftUI

struct TextFieldMaterialStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 16, weight: .regular))
    }
}
