//
//  NewsPulseUITests.swift
//  NewsPulseUITests
//
//  Created by Amitkumar on 19/08/26.
//
import XCTest

final class NewsPulseUITests: XCTestCase {
    
    func testAppLaunchesSuccessfully() {
        
        let app = XCUIApplication()
        
        app.launchArguments = ["UITesting"]
        app.launch()
        
        XCTAssertTrue(
            app.navigationBars["NewsPulse"]
                .waitForExistence(timeout: 10)
        )
    }
    func testNewsDetailNavigation() {
        
        let app = XCUIApplication()
        
        app.launchArguments = ["UITesting"]
        app.launch()
        
        let article = app.staticTexts["India Wins Cricket Match"]
        
        XCTAssertTrue(
            article.waitForExistence(timeout: 10)
        )
        
        article.tap()
        
        let detailTitle = app.staticTexts["India Wins Cricket Match"]
        
        XCTAssertTrue(
            detailTitle.waitForExistence(timeout: 10)
        )
    }
    func testSearchFiltersNews() {
        
        let app = XCUIApplication()
        
        app.launchArguments = ["UITesting"]
        app.launch()
        
        // Find the SwiftUI searchable field
        let searchField = app.searchFields.firstMatch
        
        XCTAssertTrue(
            searchField.waitForExistence(timeout: 10)
        )
        
        searchField.tap()
        searchField.typeText("India")
        
        // India article should remain
        XCTAssertTrue(
            app.staticTexts["India Wins Cricket Match"]
                .waitForExistence(timeout: 5)
        )
        
        // Apple article should disappear
        XCTAssertFalse(
            app.staticTexts["Apple Announces New iPhone"]
                .exists
        )
    }
}
