//
//  ApolloSignup.swift
//  CodeTest
//
//  Created by Aric Brown on 5/19/21.
//

import Combine
import KeychainSwift
import Foundation

final class ApolloSignup: SignupAPI {
    let keychainSwift = KeychainSwift()

    func signup(name: String, email: String, password: String) -> AnyPublisher<SignupEntity, Never> {
        return Future<SignupEntity, Never> { promise in
            Network.shared.apollo.perform(mutation: SignupMutation(name: name, email: email, password: password)) { [self] result in
                switch result {
                case .success(let graphQLResult):
                    if let signup = graphQLResult.data?.signup {
                        guard let token = signup.token else { return }
                        guard let userId = signup.user?.id else { return }
                        
                        if (!token.isEmpty && !userId.isEmpty) {
                            keychainSwift.set(token, forKey: CodeTestApp.tokenKey)
                            keychainSwift.set(userId, forKey: CodeTestApp.userIdKey)
                            
                            NotificationCenter.default.post(name: CodeTestApp.authenticatedEvent, object: nil)
                            
                            let signupEntity: SignupEntity = SignupEntity(token: token, userId: userId)
                            promise(.success(signupEntity))
                        }
                    }
                    if let errors = graphQLResult.errors {
                        print("Errors from server: \(errors)")
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
        // By default, Apollo will deliver query results on the main thread...
        .eraseToAnyPublisher()
    }
}

//{
//  "data": {
//    "signup": {
//      "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjUsImlhdCI6MTYyMTQ1MjAwOH0.jBbLZBJ-pd8BmDX4yBp28I_c4gxIiaTtdIKziCRpv28",
//      "user": {
//        "id": "5"
//      }
//    }
//  }
//}
