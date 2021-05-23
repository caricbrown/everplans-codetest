//
//  GrayFooterTextStyle.swift
//  CodeTest
//
//  Created by Aric Brown on 5/23/21.
//

import SwiftUI

struct GrayFooterTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 12))
            .foregroundColor(Color("secondaryTextColor")).lineLimit(1)
    }
}
