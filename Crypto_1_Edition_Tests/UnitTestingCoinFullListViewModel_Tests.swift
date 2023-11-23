//
//  UnitTestingCoinFullListViewModel_Tests.swift
//  Crypto_1_Edition_Tests
//
//  Created by Сергей Курьян on 23.11.2023.
//

import XCTest
import SwiftUI
import Combine

@testable import Crypto_1_Edition

final class UnitTestingCoinFullListViewModel_Tests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_CoinFullListViewModel_moyaCoins_isNotEmpty() {
        // Given
        let viewModel = CoinFullListViewModel(dataService: NetworkManager())
        // When
        let expectation = XCTestExpectation(description: "Should return data after 4 seconds.")
        
        viewModel.$moyaCoins
            .dropFirst() // Drop first Publisher, its nil - []
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.downloadCoinModelsWithEscaping()
        
        // Then
        wait(for: [expectation], timeout: 4)
        XCTAssertGreaterThan(viewModel.moyaCoins.count, 0)
    }
    
    func test_CoinFullListViewModel_moyaImages_isNotEmpty() {
        // Given
        let viewModel = CoinFullListViewModel(dataService: NetworkManager())
        // When
        let expectation = XCTestExpectation(description: "Should return Images after 4 seconds.")
        
        viewModel.$moyaImages
            .dropFirst() // Drop first Publisher, its nil - []
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.downloadImagesWithEscaping()
        
        // Then
        wait(for: [expectation], timeout: 4)
        XCTAssertGreaterThan(viewModel.moyaCoins.count, 0)
    }
}
