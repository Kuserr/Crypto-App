//
//  UnitTestingAboutCoinViewModel_Tests.swift
//  Crypto_1_Edition_Tests
//
//  Created by Сергей Курьян on 20.11.2023.
//

import XCTest

@testable import Crypto_1_Edition

final class UnitTestingAboutCoinViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_AboutCoinViewModel_quantity_shouldBeEmpty() {
        // Given
        
        // When
        let viewModel = AboutCoinViewModel(coin: CoinModel.sample, dataService: PortfolioManager(), dataServiceFav: FavouritesManager())
        // Then
        XCTAssertTrue(viewModel.quantity.isEmpty)
    }

    func test_AboutCoinViewModel_isInFav_shouldBeFalse() {
        // Given
            let coinIsInFav: Bool = false
            // When
            let viewModel = AboutCoinViewModel(coin: CoinModel.sample, dataService: PortfolioManager(), dataServiceFav: FavouritesManager())
            // Then
            XCTAssertEqual(viewModel.isInFav, coinIsInFav)
    }
}
