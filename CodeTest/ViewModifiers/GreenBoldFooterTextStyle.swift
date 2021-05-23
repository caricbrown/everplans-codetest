//
//  GreenBoldFooterTextStyle.swift
//  CodeTest
//
//  Created by Aric Brown on 5/23/21.
//

import SwiftUI

struct GreenBoldFooterTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 12, weight: .bold))
            .foregroundColor(Color.greenColor).lineLimit(1)
    }
}
