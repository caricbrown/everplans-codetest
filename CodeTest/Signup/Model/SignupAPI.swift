//
//  SignupAPI.swift
//  CodeTest
//
//  Created by Aric Brown on 5/19/21.
//

import Combine

protocol SignupAPI {
    func signup(name: String, email: String, password: String) -> AnyPublisher<SignupEntity, Never>
}
