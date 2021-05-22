//
//  CreatePost.swift
//  CodeTest
//
//  Created by Aric Brown on 5/17/21.
//

import SwiftUI

struct CreatePost: View {
    @EnvironmentObject var bottomSheetState: BottomSheetState
    
    @ObservedObject var viewModel = CreatePostViewModel()
    
    init(viewModel: CreatePostViewModel = .init()) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Text("Got something to post?")
                .font(.system(size: 24, weight: .medium))
            
            TextField("URL", text: $viewModel.url)
                .modifier(TextFieldMaterialStyle())
                .underlineTextField()
            
            TextField("Title", text: $viewModel.title)
                .modifier(TextFieldMaterialStyle())
                .underlineTextField()
            
            Button(action: viewModel.createPost) {
                HStack {
                    Spacer()
                    Text(viewModel.buttonTitle)
                    Spacer()
                }
            }
            .buttonStyle(ButtonPrimaryStyle())
            .disabled(!viewModel.isFormValid)
            
            Button("Cancel", action: handleCancelAction)
                .foregroundColor(Color.greenColor)
            
            Spacer()
        }
    }
}

extension CreatePost {
    func handleCancelAction() -> Void {
        self.bottomSheetState.isOpen.toggle()
    }
}

struct CreatePost_Previews: PreviewProvider {
    static var previews: some View {
        CreatePost()
    }
}
