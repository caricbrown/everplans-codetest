//
//  CreatePostViewModel.swift
//  CodeTest
//
//  Created by Aric Brown on 5/17/21.
//

import Combine
import Foundation

final class CreatePostViewModel: ObservableObject {
    @Published var url = ""
    @Published var title = ""

    @Published var isFormValid = false
    @Published var formValidationMessage = ""
    
    var buttonTitle: String = "Post"
    
    private let postApi: CreatePostAPI
    private var cancellableSet: Set<AnyCancellable> = []

    init(postApi: CreatePostAPI = ApolloCreatePost()) {
        self.postApi = postApi
        
        urlValidationPublisher
            .receive(on: RunLoop.main)
            .map { $0 ? " " : "URL is required"}
            .assign(to: \.formValidationMessage, on: self)
            .store(in: &cancellableSet)
        
        titleValidationPublisher
            .receive(on: RunLoop.main)
            .map { $0 ? " " : "Title is required"}
            .assign(to: \.formValidationMessage, on: self)
            .store(in: &cancellableSet)
        
        formValidationPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellableSet)
    }
        
    func createPost() {
        postApi.createPost(url: url, title: title)
            .sink(receiveCompletion:{ _ in }, receiveValue: { result in
                /*
                 * There is no real reason to return anything but Void here.
                 */
            })
            .store(in: &cancellableSet)
    }
}

private extension CreatePostViewModel {
    var urlValidationPublisher: AnyPublisher<Bool, Never> {
        $url
            .removeDuplicates()
            .map { input in
                return input.count >= 3
            }
            .eraseToAnyPublisher()
    }
    
    var titleValidationPublisher: AnyPublisher<Bool, Never> {
        $title
            .removeDuplicates()
            .map { input in
                return input.count >= 3
            }
            .eraseToAnyPublisher()
    }
    
    var formValidationPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(urlValidationPublisher, titleValidationPublisher)
            .map { urlIsValid, titleIsValid in
                return (urlIsValid && titleIsValid)
            }
            .eraseToAnyPublisher()
    }
}

