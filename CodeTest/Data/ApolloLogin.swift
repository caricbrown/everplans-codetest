//
//  ApolloAPI.swift
//  CodeTest
//
//  Created by Aric Brown on 5/20/21.
//

import Combine
import KeychainSwift
import Foundation

final class ApolloLogin: LoginAPI {
    func login(email: String, password: String) -> AnyPublisher<LoginEntity, Never> {
        return Future<LoginEntity, Never> { promise in
            Network.shared.apollo.perform(mutation: LoginMutation(email: email, password: password)) { result in
                switch result {
                case .success(let graphQLResult):
                    if let login = graphQLResult.data?.login {
                        guard let token = login.token else { return }
                        guard let userId = login.user?.id else { return }
                        
                        if let links = login.user?.links {
                            print(links) // TODO return the links...
                        }
                        
                        if (!token.isEmpty && !userId.isEmpty) {
                            let keychainSwift = KeychainSwift()
                            keychainSwift.set(token, forKey: CodeTestApp.tokenKey)
                            keychainSwift.set(userId, forKey: CodeTestApp.userIdKey)
                            
                            NotificationCenter.default.post(name: CodeTestApp.authenticatedEvent, object: nil)
                            
                            let result: LoginEntity = LoginEntity(token: token, userId: userId)
                            promise(.success(result))
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
