//
//  Assignment_POCTests.swift
//  Assignment_POCTests
//
//  Created by Pooja on 26/02/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import XCTest
@testable import Assignment_POC

class AssignmentPOCTests: XCTestCase {
    var viewControllerUnderTest: ViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        self.viewControllerUnderTest.loadView()
        self.viewControllerUnderTest.viewDidLoad()
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testHasATableView() {
        XCTAssertNotNil(viewControllerUnderTest.tableViewFacts)
    }
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.tableViewFacts.dataSource)
    }
    func testTableViewHasDelegater() {
        XCTAssertNotNil(viewControllerUnderTest.tableViewFacts.delegate)
    }
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:cellForRowAt:))))
    }

}
