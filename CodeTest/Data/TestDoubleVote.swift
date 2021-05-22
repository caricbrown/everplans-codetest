//
//  TestDoubleVote.swift
//  CodeTest
//
//  Created by Aric Brown on 5/22/21.
//

import Combine
import Foundation

final class TestDoubleVote: VoteAPI {
    func getVotes() -> AnyPublisher<[String], Never> {
        return Future<[String], Never> { promise in
            promise(.success([]))
        }
        .eraseToAnyPublisher()
    }
    
    func upvote(id: String) -> AnyPublisher<VoteEntity, Never> {
        return Future<VoteEntity, Never> { promise in
            let vote = VoteEntity(id: id, votes: 99)
            promise(.success(vote))
        }
        .eraseToAnyPublisher()
    }
    
    func downvote(id: String) -> AnyPublisher<VoteEntity, Never> {
        return Future<VoteEntity, Never> { promise in
            let vote = VoteEntity(id: id, votes: 99)
            promise(.success(vote))
        }
        .eraseToAnyPublisher()    }
}
