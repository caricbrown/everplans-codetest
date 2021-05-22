//
//  LoginAPI.swift
//  CodeTest
//
//  Created by Aric Brown on 5/20/21.
//

import Combine

protocol LoginAPI {
    func login(email: String, password: String) -> AnyPublisher<LoginEntity, Never>
}
