//
//  ViewControllerUITests.swift
//  Zen
//
//  Created by Isaac Overacker on 6/3/16.
//
//

import XCTest

class ViewControllerUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        let defaultZen = app.staticTexts["Zen Quote"]
        XCTAssert(defaultZen.exists)

        let doesNotExist = NSPredicate(format: "exists == false")
        expectationForPredicate(doesNotExist, evaluatedWithObject: defaultZen, handler: nil)

        XCTAssert(app.buttons["Zen"].hasFocus)
        XCUIRemote.sharedRemote().pressButton(.Select)

        waitForExpectationsWithTimeout(15, handler: nil)
        XCTAssertFalse(defaultZen.exists)
    }

}
