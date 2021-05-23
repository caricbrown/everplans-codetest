//
//  LoginViewModel.swift
//  CodeTest
//
//  Created by Aric Brown on 5/16/21.
//

import Combine
import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    @Published var isFormValid = false
    @Published var formValidationMessage = ""
    
    private let loginApi: LoginAPI
    private var cancellableSet: Set<AnyCancellable> = []

    init(loginApi: LoginAPI = ApolloLogin()) {
        self.loginApi = loginApi
        
        emailValidationPublisher
            .receive(on: RunLoop.main)
            .map { $0 ? " " : "Email is required"}
            .assign(to: \.formValidationMessage, on: self)
            .store(in: &cancellableSet)
        
        passwordValidationPublisher
            .receive(on: RunLoop.main)
            .map { $0 ? " " : "Password is required"}
            .assign(to: \.formValidationMessage, on: self)
            .store(in: &cancellableSet)
        
        formValidationPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellableSet)
    }
    
    var barTitle: String = "Log In"
    var buttonTitle: String = "Log In"
    
    func login() {
        loginApi.login(email: email, password: password)
            .sink(receiveCompletion:{ _ in }, receiveValue: { result in
                /*
                 * Making the VM responsible for updating "App State" is not ideal.
                 * There is no real reason to return anything but Void here.
                 */
            })
            .store(in: &cancellableSet)
    }
}

private extension LoginViewModel {
    var emailValidationPublisher: AnyPublisher<Bool, Never> {
        $email
            .removeDuplicates()
            .map { input in
                return input.count >= 3
            }
            .eraseToAnyPublisher()
    }
    
    var passwordValidationPublisher: AnyPublisher<Bool, Never> {
        $password
            .removeDuplicates()
            .map { input in
                return input.count >= 3
            }
            .eraseToAnyPublisher()
    }
    
    var formValidationPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(emailValidationPublisher, passwordValidationPublisher)
            .map { emailIsValid, passwordIsValid in
                return (emailIsValid && passwordIsValid)
            }
            .eraseToAnyPublisher()
    }
}

