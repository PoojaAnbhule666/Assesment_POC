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
    var vcntrTest: FactViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.vcntrTest = FactViewController()
        self.vcntrTest.loadView()
        self.vcntrTest.viewDidLoad()
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testHasATableView() {
        XCTAssertNotNil(vcntrTest.tableViewFacts)
    }
    func testTableViewHasDataSource() {
        XCTAssertNotNil(vcntrTest.tableViewFacts.dataSource)
    }
    func testTableViewHasDelegater() {
        XCTAssertNotNil(vcntrTest.tableViewFacts.delegate)
    }
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(vcntrTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(vcntrTest.responds(to: #selector(vcntrTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(vcntrTest.responds(to: #selector(vcntrTest.tableView(_:cellForRowAt:))))
    }

}
