//
//  ApolloVote.swift
//  CodeTest
//
//  Created by Aric Brown on 5/21/21.
//

import Combine
import Foundation

final class ApolloVote: VoteAPI {
    let cachedVotes: [String] = UserDefaults.standard.stringArray(forKey: "votes") ?? []
    
    func getVotes() -> AnyPublisher<[String], Never> {
        return Future<[String], Never> { [self] promise in
            promise(.success(cachedVotes))
        }
        .eraseToAnyPublisher()
    }
    
    func upvote(id: String) -> AnyPublisher<VoteEntity, Never> {
        return Future<VoteEntity, Never> { promise in
            Network.shared.apollo.perform(mutation: UpvoteMutation(id: id)) { [self] result in
                switch result {
                case .success(let graphQLResult):
                    if let upvote = graphQLResult.data?.upvote {
                        var nextArray = cachedVotes
                        nextArray.append(upvote.id)
                        UserDefaults.standard.set(nextArray, forKey: "votes")
                        
                        let result: VoteEntity = VoteEntity(id: upvote.id, votes: upvote.votes)
                        promise(.success(result))
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
    
    func downvote(id: String) -> AnyPublisher<VoteEntity, Never> {
        return Future<VoteEntity, Never> { promise in
            Network.shared.apollo.perform(mutation: DownvoteMutation(id: id)) { [self] result in
                switch result {
                case .success(let graphQLResult):
                    if let downvote = graphQLResult.data?.downvote {
                        let id = downvote.id
                        let nextArray = cachedVotes.filter { $0 != id }
                        
                        UserDefaults.standard.set(nextArray, forKey: "votes")
                        
                        let result: VoteEntity = VoteEntity(id: downvote.id, votes: downvote.votes)
                        promise(.success(result))
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
