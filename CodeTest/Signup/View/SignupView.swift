//
//  SignupView.swift
//  CodeTest
//
//  Created by Aric Brown on 5/16/21.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var viewModel = SignupViewModel()
    
    init(viewModel: SignupViewModel = .init()) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    @State var sheetDisplayed = false
    
    func handleSignUpAction() -> Void {
        viewModel.signup()
    }
    
    var body: some View {
        NavigationView {
            VStack{
                
                Spacer()
                
                TextField("Name", text: $viewModel.name)
                    .modifier(TextFieldCustomStyle())
                
                TextField("Email", text: $viewModel.email)
                    .modifier(TextFieldCustomStyle())
                
                SecureField("Password", text: $viewModel.password)
                    .modifier(TextFieldCustomStyle())
                
                Spacer()
                
                Button(action: handleSignUpAction) {
                    HStack {
                        Spacer()
                        Text(viewModel.buttonTitle)
                        Spacer()
                    }
                }
                .buttonStyle(ButtonPrimaryStyle())
                .disabled(!viewModel.isFormValid)
                
                //                Text(viewModel.formValidationMessage) // This is cool, but not part of the requirements.
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(viewModel.barTitle).font(.system(size: 30, weight: .semibold))
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { self.sheetDisplayed.toggle() }) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
        .navigationBarColor(backgroundColor: .white, tintColor: Color.greenColor)
        .sheet(isPresented: $sheetDisplayed) {
            LoginView(sheetDisplayed: self.$sheetDisplayed)
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
