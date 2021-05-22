//
//  LoginEntity.swift
//  CodeTest
//
//  Created by Aric Brown on 5/21/21.
//

import Foundation

struct LoginEntity {
    let token: String?
    let userId: String?
    
    init(token: String?, userId: String?) {
        self.token = token
        self.userId = userId
    }
}
