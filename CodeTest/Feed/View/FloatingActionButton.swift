//
//  FloatingActionButton.swift
//  CodeTest
//
//  Created by Aric Brown on 5/17/21.
//

import SwiftUI

struct FloatingActionButton: View {
    var action: (() -> Void)?
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Button(action: {
                    if (self.action != nil) {
                        self.action!()
                    }
                }) {
                    Text("+")
                        .font(.system(size: 50, weight: .light, design: .rounded))
                        .foregroundColor(Color.white)
                        .padding(.bottom, 7)
                        .frame(width: 64, height: 64)
                }
                .background(Color("greenColor"))
                .cornerRadius(32)
                .padding()
                .shadow(color: Color.black.opacity(0.3),
                        radius: 3,
                        x: 3,
                        y: 3)
            }
        }
    }
}

struct FloatingActionButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingActionButton()
    }
}

