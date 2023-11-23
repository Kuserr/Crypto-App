//
//  UnitTestingFavouritesManager_Tests.swift
//  Crypto_1_Edition_Tests
//
//  Created by Сергей Курьян on 21.11.2023.
//

import XCTest
@testable import Crypto_1_Edition

final class UnitTestingFavouritesManager_Tests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_FavouritesManager_context_shouldContainCoinModel() {
        // Given
        let manager = FavouritesManager()
        // When
        manager.save(coinModel: CoinModel.sample)
        // Then
        XCTAssertEqual(manager.load().first(where: {$0.name == CoinModel.sample.name})?.name, CoinModel.sample.name)
    }

    func test_FavouritesManager_context_shouldNotContainCoinModel() {
        // Given
        let manager = FavouritesManager()
        // When
        manager.removeCoin(withId: String(CoinModel.sample.id))
        // Then
        XCTAssertFalse(manager.load().contains(where: {$0.name == CoinModel.sample.name}))
    }
    
}
