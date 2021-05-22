//
//  VoteEntity.swift
//  CodeTest
//
//  Created by Aric Brown on 5/21/21.
//

import Foundation

struct VoteEntity {
    let id: String
    let votes: Int

    init(id: String, votes: Int) {
        self.id = id
        self.votes = votes
    }
}
