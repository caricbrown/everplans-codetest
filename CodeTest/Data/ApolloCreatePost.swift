//
//  ApolloCreatePost.swift
//  CodeTest
//
//  Created by Aric Brown on 5/21/21.
//

import Combine
import Foundation

final class ApolloCreatePost: CreatePostAPI {
    func createPost(url: String, title: String) -> AnyPublisher<CreatePostEntity, Never> {
        return Future<CreatePostEntity, Never> { promise in
            Network.shared.apollo.perform(mutation: CreatePostMutation(url: url, description: title)) { result in
                switch result {
                case .success(let graphQLResult):
                    if let post = graphQLResult.data?.post {
                        print(post) // TODO
                        
                        let result: CreatePostEntity = CreatePostEntity(id: post.id)
                        promise(.success(result))
                        
                        NotificationCenter.default.post(name: CodeTestApp.createPostEvent, object: nil)
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
