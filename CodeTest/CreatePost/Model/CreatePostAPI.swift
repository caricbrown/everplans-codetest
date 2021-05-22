//
//  CreatePostAPI.swift
//  CodeTest
//
//  Created by Aric Brown on 5/18/21.
//

import Combine

protocol CreatePostAPI {
    func createPost(url: String, title: String) -> AnyPublisher<CreatePostEntity, Never>
}
