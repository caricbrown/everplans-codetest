//
//  SignupEntity.swift
//  CodeTest
//
//  Created by Aric Brown on 5/19/21.
//

import Foundation

struct SignupEntity {
    let token: String?
    let userId: String?
    
    init(token: String?, userId: String?) {
        self.token = token
        self.userId = userId
    }
}
