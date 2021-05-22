//
//  LoginView.swift
//  CodeTest
//
//  Created by Aric Brown on 5/16/21.
//

import SwiftUI

struct LoginView: View {
    @Binding var sheetDisplayed: Bool
    @ObservedObject var viewModel = LoginViewModel()
    
    init(sheetDisplayed: Binding<Bool> = .constant(false), viewModel: LoginViewModel = .init()) {
        _sheetDisplayed = sheetDisplayed
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack{
                
                Spacer()
                
                TextField("Email", text: $viewModel.email)
                    .modifier(TextFieldCustomStyle())
                
                SecureField("Password", text: $viewModel.password)
                    .modifier(TextFieldCustomStyle())
                
                Spacer()
                
                Button(action: handleLoginAction) {
                    HStack {
                        Spacer()
                        Text(viewModel.buttonTitle)
                        Spacer()
                    }
                }
                .buttonStyle(ButtonPrimaryStyle())
                .disabled(!viewModel.isFormValid)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(viewModel.barTitle).font(.system(size: 30, weight: .semibold))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: handleSignUpAction) {
                        Text("Sign Up")
                    }
                }
            }
        }
        .navigationBarColor(backgroundColor: .white, tintColor: Color.greenColor)
    }
}

extension LoginView {
    func handleLoginAction() -> Void {
        viewModel.login()
    }
    
    func handleSignUpAction() -> Void {
        self.sheetDisplayed.toggle()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
