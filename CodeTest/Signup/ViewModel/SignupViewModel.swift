//
//  AuthViewModel.swift
//  CodeTest
//
//  Created by Aric Brown on 5/16/21.
//

import Combine
import SwiftUI

final class SignupViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    
    @Published var isFormValid = false
    @Published var formValidationMessage = ""
    
    private let signupApi: SignupAPI
    private var cancellableSet: Set<AnyCancellable> = []

    init(signupApi: SignupAPI = ApolloSignup()) {
        self.signupApi = signupApi
        
        nameValidationPublisher
            .receive(on: RunLoop.main)
            .map { $0 ? " " : "Name is required"}
            .assign(to: \.formValidationMessage, on: self)
            .store(in: &cancellableSet)
        
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
    
    func signup() {
        signupApi.signup(name: name, email: email, password: password)
            .sink(receiveCompletion:{ _ in }, receiveValue: { result in
                /*
                 * Making the VM responsible for updating "App State" is not ideal.
                 * There is no real reason to return anything but Void here.
                 */
            })
            .store(in: &cancellableSet)
    }
    
    var barTitle: String = "Sign Up"
    
    var buttonTitle: String = "Sign Up"
}

private extension SignupViewModel {
    var nameValidationPublisher: AnyPublisher<Bool, Never> {
        $name
            .removeDuplicates()
            .map { input in
                return input.count >= 3
            }
            .eraseToAnyPublisher()
    }
    
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
        Publishers.CombineLatest3(nameValidationPublisher, emailValidationPublisher, passwordValidationPublisher)
            .map { nameIsValid, emailIsValid, passwordIsValid in
                return (nameIsValid && emailIsValid && passwordIsValid)
            }
            .eraseToAnyPublisher()
    }
}
