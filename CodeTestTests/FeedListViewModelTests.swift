//
//  FeedListViewModelTests.swift
//  CodeTestTests
//
//  Created by Aric Brown on 5/22/21.
//

import XCTest
import Combine
@testable import CodeTest

class FeedListViewModelTests: XCTestCase {
    // MARK: SUT
    var feedListViewModel:FeedListViewModel!
    
    override func setUpWithError() throws {
        feedListViewModel = FeedListViewModel.loadedState()
    }
    
    func test_FeedItemsIsSorted() throws {
        let expectNotEmpty = expectValue(of: feedListViewModel.$feedItems, equalsTo: { !$0.isEmpty })
        let expectSorted = expectValue(of: feedListViewModel.$feedItems, equalsTo: { $0.first?.index == 1 })
        
        feedListViewModel.getSortedFeed()
        
        wait(for: [expectNotEmpty.expectation, expectSorted.expectation], timeout: 1)
    }
    
}

extension XCTestCase {
    typealias CompletionResult = (expectation: XCTestExpectation, cancellable: AnyCancellable)
    
    func expectValue<T: Publisher>(of publisher: T, equalsTo closure: @escaping(T.Output) -> Bool) -> CompletionResult {
        let expectationResult = expectation(description: "values: " + String(describing: publisher))
        let cancellable = publisher.sink(receiveCompletion: { _ in },
                                         receiveValue: {
                                            if closure($0) {
                                                expectationResult.fulfill()
                                            }
                                         })
        return (expectationResult, cancellable)
    }
}
