//
//  VoteAPI.swift
//  CodeTest
//
//  Created by Aric Brown on 5/21/21.
//

import Combine

protocol VoteAPI {
    func getVotes() -> AnyPublisher<[String], Never>
    func upvote(id: String) -> AnyPublisher<VoteEntity, Never>
    func downvote(id: String) -> AnyPublisher<VoteEntity, Never>
}
